<template>
  <div>
    <!-- 聊天界面 -->
    <div
      class="chat-container animated bounceInUp"
      v-show="isShow"
      @click="closeAll"
      @contextmenu.prevent.stop="closeAll"
    >
      <!-- 标题 -->
      <div class="header">
        <img
          width="32"
          height="32"
          src="https://www.static.talkxj.com/logo%20copy.png"
        />
        <div style="margin-left:12px">
          <div>聊天室</div>
          <div style="font-size:12px">当前{{ count }}人在线</div>
        </div>
        <v-icon class="close" @click="isShow = false">
          mdi-close
        </v-icon>
      </div>
      <!-- 对话内容 -->
      <div class="message" id="message">
        <!-- 录音遮罩层 -->
        <div
          v-show="voiceActive"
          class="voice"
          @mousemove.prevent.stop="translationmove($event)"
          @mouseup.prevent.stop="translationEnd($event)"
        >
          <v-icon ref="voiceClose" class="close-voice">mdi-close</v-icon>
        </div>
        <div
          :class="isMyMessage(item)"
          v-for="(item, index) of chatRecordList"
          :key="index"
        >
          <!-- 头像 -->
          <img :src="item.avatar" :class="isleft(item)" />
          <div>
            <div class="nickname" v-if="!isSelf(item)">
              {{ item.nickname }}
              <span style="margin-left:12px">{{ item.createTime | hour }}</span>
            </div>
            <!-- 内容 -->
            <div
              ref="content"
              @contextmenu.prevent.stop="showBack(item, index, $event)"
              :class="isMyContent(item)"
            >
              <!-- 文字消息 -->
              <div v-if="item.type == 3" v-html="item.content" />
              <!-- 语音消息 -->
              <div v-if="item.type == 5" @click.prevent.stop="playVoice(item)">
                <audio
                  @ended="endVoice(item)"
                  @canplay="getVoiceTime(item)"
                  ref="voices"
                  :src="item.content"
                  style="display:none"
                />
                <!-- 播放 -->
                <v-icon
                  :color="isSelf(item) ? '#fff' : '#000'"
                  ref="plays"
                  style="display:inline-flex;cursor: pointer;"
                >
                  mdi-arrow-right-drop-circle
                </v-icon>
                <!-- 暂停 -->
                <v-icon
                  :color="isSelf(item) ? '#fff' : '#000'"
                  ref="pauses"
                  style="display:none;cursor: pointer;"
                >
                  mdi-pause-circle
                </v-icon>
                <!-- 音频时长 -->
                <span ref="voiceTimes" />
              </div>
              <div class="back-menu" ref="backBtn" @click="back(item, index)">
                撤回
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- 输入框 -->
      <div class="footer">
        <!-- 表情框 -->
        <div class="emoji-box" v-show="isEmoji">
          <Emoji :chooseEmoji="true" @addEmoji="addEmoji" />
        </div>
        <div class="emoji-border" v-show="isEmoji" />
        <!-- 切换输入方式 -->
        <v-icon
          v-show="!isVoice"
          @click="isVoice = !isVoice"
          style="margin-right: 8px"
        >
          mdi-microphone
        </v-icon>
        <v-icon
          v-show="isVoice"
          @click="isVoice = !isVoice"
          style="margin-right: 8px"
        >
          mdi-keyboard
        </v-icon>
        <!-- 文字输入 -->
        <textarea
          v-show="!isVoice"
          ref="chatInput"
          v-model="content"
          @keydown.enter="saveMessage($event)"
          placeholder="请输入内容"
        />
        <!-- 语音输入 -->
        <button
          class="voice-btn"
          v-show="isVoice"
          @mousedown.prevent.stop="translationStart"
          @mouseup.prevent.stop="translationEnd($event)"
          @touchstart.prevent.stop="translationStart"
          @touchend.prevent.stop="translationEnd($event)"
          @touchmove.prevent.stop="translationmove($event)"
        >
          按住说话
        </button>
        <!-- 表情 -->
        <i
          class="iconfont iconbiaoqing emoji"
          :style="isEmoji ? 'color:#FFC83D' : ''"
          @click.prevent.stop="openEmoji"
        />
        <!-- 发送按钮 -->
        <i :class="isInput" @click="saveMessage" style="font-size: 1.5rem" />
      </div>
    </div>
    <!-- 未读数量 -->
    <div class="chat-btn" @click="open">
      <span class="unread" v-if="unreadCount > 0">{{ unreadCount }}</span>
      <img
        width="100%"
        height="100%"
        src="https://www.static.talkxj.com/logo%20copy.png"
      />
    </div>
  </div>
</template>

<script>
import Recorderx, { ENCODE_TYPE } from "recorderx";
import Emoji from "./Emoji";
import EmojiList from "../assets/js/emoji";
export default {
  components: {
    Emoji
  },
  updated() {
    var ele = document.getElementById("message");
    ele.scrollTop = ele.scrollHeight;
  },
  beforeDestroy() {
    clearInterval(this.heartBeat);
  },
  data: function() {
    return {
      isEmoji: false,
      isShow: false,
      websocket: null,
      content: "",
      chatRecordList: [],
      voiceList: [],
      rc: null,
      ipAddr: "",
      ipSource: "",
      count: 0,
      unreadCount: 0,
      isVoice: false,
      voiceActive: false,
      startVoiceTime: null,
      WebsocketMessage: {
        type: null,
        data: null
      },
      heartBeat: null
    };
  },
  methods: {
    open() {
      if (this.websocket == null) {
        this.connect();
      }
      this.unreadCount = 0;
      this.isShow = !this.isShow;
    },
    openEmoji() {
      this.isEmoji = !this.isEmoji;
      this.isVoice = false;
    },
    connect() {
      var that = this;
      console.log("建立连接");
      this.websocket = new WebSocket("ws://127.0.0.1:8080/websocket");
      // 连接发生错误的回调方法
      this.websocket.onerror = function(event) {
        console.log(event);
        alert("失败");
      };
      // 连接成功建立的回调方法
      this.websocket.onopen = function(event) {
        console.log(event);
        // 发送心跳消息
        that.heartBeat = setInterval(function() {
          var beatMessage = {
            type: 6,
            data: "ping"
          };
          that.websocket.send(JSON.stringify(beatMessage));
        }, 30 * 1000);
      };
      // 接收到消息的回调方法
      this.websocket.onmessage = function(event) {
        const data = JSON.parse(event.data);
        switch (data.type) {
          case 1:
            // 在线人数
            that.count = data.data;
            break;
          case 2:
            // 历史记录
            that.chatRecordList = data.data.chatRecordList;
            that.chatRecordList.forEach(item => {
              if (item.type == 5) {
                that.voiceList.push(item.id);
              }
            });
            that.ipAddr = data.data.ipAddr;
            that.ipSource = data.data.ipSource;
            break;
          case 3:
            // 文字消息
            that.chatRecordList.push(data.data);
            if (!that.isShow) {
              that.unreadCount++;
            }
            break;
          case 4:
            // 撤回
            if (data.data.isVoice) {
              that.voiceList.splice(that.voiceList.indexOf(data.data.id), 1);
            }
            for (var i = 0; i < that.chatRecordList.length; i++) {
              if (that.chatRecordList[i].id == data.data.id) {
                that.chatRecordList.splice(i, 1);
                i--;
              }
            }
            break;
          case 5:
            // 语音消息
            that.voiceList.push(data.data.id);
            that.chatRecordList.push(data.data);
            if (!that.isShow) {
              that.unreadCount++;
            }
            break;
        }
      };
      //连接关闭的回调方法
      this.websocket.onclose = function() {};
    },
    saveMessage(e) {
      e.preventDefault();
      if (this.content.trim() == "") {
        this.$toast({ type: "error", message: "内容不能为空" });
        return false;
      }
      //解析表情
      var reg = /\[.+?\]/g;
      this.content = this.content.replace(reg, function(str) {
        return (
          "<img style='vertical-align: middle' src= '" +
          EmojiList[str] +
          "' width='22'height='20' style='padding: 0 1px'/>"
        );
      });
      var socketMsg = {
        nickname: this.nickname,
        avatar: this.avatar,
        content: this.content,
        userId: this.userId,
        type: 3,
        ipAddr: this.ipAddr,
        ipSource: this.ipSource,
        createTime: new Date()
      };
      this.WebsocketMessage.type = 3;
      this.WebsocketMessage.data = socketMsg;
      this.websocket.send(JSON.stringify(this.WebsocketMessage));
      this.content = "";
    },
    addEmoji(key) {
      this.isEmoji = false;
      this.$refs.chatInput.focus();
      this.content += key;
    },
    // 展示菜单
    showBack(item, index, e) {
      this.$refs.backBtn.forEach(item => {
        item.style.display = "none";
      });
      if (
        item.ipAddr == this.ipAddr ||
        (item.userId != null && item.userId == this.userId)
      ) {
        this.$refs.backBtn[index].style.left = e.offsetX + "px";
        this.$refs.backBtn[index].style.bottom = e.offsetY + "px";
        this.$refs.backBtn[index].style.display = "block";
      }
    },
    // 撤回消息
    back(item, index) {
      var socketMsg = {
        id: item.id,
        isVoice: item.type == 5
      };
      this.WebsocketMessage.type = 4;
      this.WebsocketMessage.data = socketMsg;
      this.websocket.send(JSON.stringify(this.WebsocketMessage));
      this.$refs.backBtn[index].style.display = "none";
    },
    closeAll() {
      this.isEmoji = false;
      if (this.chatRecordList.length > 0) {
        this.$refs.backBtn.forEach(item => {
          item.style.display = "none";
        });
      }
    },
    // 录音开始
    translationStart() {
      this.voiceActive = true;
      let that = this;
      that.rc = new Recorderx();
      that.$nextTick(() => {
        that.rc
          .start()
          .then(() => {
            that.startVoiceTime = new Date();
            console.log("start recording");
          })
          .catch(error => {
            console.log("Recording failed.", error);
          });
      });
    },
    // 录音结束
    translationEnd() {
      console.log("结束");
      this.voiceActive = false;
      this.rc.pause();
      if (new Date() - this.startVoiceTime < 1000) {
        this.$toast({ type: "error", message: "按键时间太短" });
        return false;
      }
      var wav = this.rc.getRecord({
        encodeTo: ENCODE_TYPE.WAV
      });
      var file = new File([wav], "voice.wav", {
        type: wav.type
      });
      var formData = new window.FormData();
      formData.append("file", file);
      formData.append("type", 5);
      formData.append("nickname", this.nickname);
      formData.append("avatar", this.avatar);
      if (this.userId != null) {
        formData.append("userId", this.userId);
      }
      formData.append("ipAddr", this.ipAddr);
      formData.append("ipSource", this.ipSource);
      formData.append("createTime", new Date());
      var options = {
        url: "/api/voice",
        data: formData,
        method: "post",
        headers: {
          "Content-Type": "multipart/form-data"
        }
      };
      this.axios(options);
    },
    translationmove() {},
    // 播放语音
    playVoice(item) {
      var player = this.$refs.voices[this.voiceList.indexOf(item.id)];
      if (player.paused) {
        player.play();
        this.$refs.plays[this.voiceList.indexOf(item.id)].$el.style.display =
          "none";
        this.$refs.pauses[this.voiceList.indexOf(item.id)].$el.style.display =
          "inline-flex";
      } else {
        this.$refs.plays[this.voiceList.indexOf(item.id)].$el.style.display =
          "inline-flex";
        this.$refs.pauses[this.voiceList.indexOf(item.id)].$el.style.display =
          "none";
        player.pause();
      }
    },
    // 语音结束
    endVoice(item) {
      this.$refs.plays[this.voiceList.indexOf(item.id)].$el.style.display =
        "inline-flex";
      this.$refs.pauses[this.voiceList.indexOf(item.id)].$el.style.display =
        "none";
    },
    // 获取语音时长
    getVoiceTime(item) {
      var time = this.$refs.voices[this.voiceList.indexOf(item.id)].duration;
      time = Math.ceil(time);
      var str = "⬝⬝⬝";
      for (var i = 0; i < time; i++) {
        if (i % 2 == 0) {
          str += "⬝";
        }
      }
      this.$refs.voiceTimes[this.voiceList.indexOf(item.id)].innerHTML =
        " " + str + " " + time + " ''";
    }
  },
  computed: {
    isSelf() {
      return function(item) {
        return (
          item.ipAddr == this.ipAddr ||
          (item.userId != null && item.userId == this.userId)
        );
      };
    },
    isleft() {
      return function(item) {
        return this.isSelf(item)
          ? "user-avatar right-avatar"
          : "user-avatar left-avatar";
      };
    },
    isMyContent() {
      return function(item) {
        return this.isSelf(item) ? "my-content" : "user-content";
      };
    },
    isMyMessage() {
      return function(item) {
        return this.isSelf(item) ? "my-message" : "user-message";
      };
    },
    nickname() {
      return this.$store.state.nickname != null
        ? this.$store.state.nickname
        : this.ipAddr;
    },
    avatar() {
      return this.$store.state.avatar != null
        ? this.$store.state.avatar
        : "https://gravatar.loli.net/avatar/d41d8cd98f00b204e9800998ecf8427e?d=mp&v=1.4.14";
    },
    userId() {
      return this.$store.state.userId;
    },
    isInput() {
      return this.content.trim() != ""
        ? "iconfont iconzhifeiji submit-btn"
        : "iconfont iconzhifeiji";
    }
  }
};
</script>

<style scoped>
@media (min-width: 760px) {
  .chat-container {
    position: fixed;
    bottom: 104px;
    right: 20px;
    height: calc(85% - 64px - 20px);
    max-height: 590px !important;
    min-height: 250px !important;
    width: 400px !important;
    border-radius: 16px !important;
  }
  .close {
    display: none;
  }
}
@media (max-width: 760px) {
  .chat-container {
    position: fixed;
    top: 0;
    bottom: 0;
    right: 0;
    left: 0;
  }
  .close {
    display: block;
    margin-left: auto;
  }
}
.chat-container {
  box-shadow: 0 5px 40px rgba(0, 0, 0, 0.16) !important;
  font-size: 14px;
  background: #f4f6fb;
  z-index: 1200;
}
.chat-btn {
  background: #1f93ff;
  border-radius: 100px !important;
  position: fixed;
  bottom: 15px;
  right: 5px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.16) !important;
  cursor: pointer;
  height: 60px !important;
  width: 60px !important;
  z-index: 1000 !important;
  user-select: none;
}
.header {
  display: flex;
  align-items: center;
  padding: 20px 24px;
  background: #ffffff;
  border-radius: 1rem 1rem 0 0;
  box-shadow: 0 10px 15px -16px rgba(50, 50, 93, 0.08),
    0 4px 6px -8px rgba(50, 50, 93, 0.04);
}
.footer {
  padding: 8px 16px;
  position: absolute;
  width: 100%;
  bottom: 0;
  background: #f7f7f7;
  border-radius: 0 0 1rem 1rem;
  display: flex;
  align-items: center;
}
.footer textarea {
  background: #fff;
  padding-left: 10px;
  padding-top: 8px;
  width: 100%;
  height: 32px;
  outline: none;
  resize: none;
  overflow: hidden;
  font-size: 13px;
}
.voice-btn {
  font-size: 13px;
  outline: none;
  height: 32px;
  width: 100%;
  background: #fff;
  border-radius: 2px;
}
.message {
  position: absolute;
  width: 100%;
  padding: 20px 16px 0 16px;
  top: 80px;
  bottom: 50px;
  overflow-y: auto;
  overflow-x: hidden;
}
.text {
  color: #999;
  text-align: center;
  font-size: 12px;
  margin-bottom: 12px;
}
.user-message {
  display: flex;
  margin-bottom: 10px;
}
.my-message {
  display: flex;
  margin-bottom: 10px;
  justify-content: flex-end;
}
.left-avatar {
  margin-right: 10px;
}
.right-avatar {
  order: 1;
  margin-left: 10px;
}
.user-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
}
.nickname {
  display: flex;
  align-items: center;
  font-size: 12px;
  margin-top: 3px;
  margin-bottom: 5px;
}
.user-content {
  position: relative;
  background-color: #fff;
  padding: 10px;
  border-radius: 5px 20px 20px 20px;
  width: fit-content;
}
.my-content {
  position: relative;
  border-radius: 20px 5px 20px 20px;
  padding: 12px;
  background: #12b7f5;
  color: #fff;
}
.submit-btn {
  color: rgb(31, 147, 255);
}
.emoji {
  cursor: pointer;
  font-size: 1.3rem;
  margin: 0 8px;
}
.emoji-box {
  position: absolute;
  box-shadow: 0 8px 16px rgba(50, 50, 93, 0.08), 0 4px 12px rgba(0, 0, 0, 0.07);
  background: #fff;
  border-radius: 8px;
  right: 20px;
  bottom: 52px;
  height: 180px;
  width: 300px;
  overflow-y: auto;
  padding: 6px 16px;
}
.emoji-border:before {
  display: block;
  height: 0;
  width: 0;
  content: "";
  border-left: 14px solid transparent;
  border-right: 14px solid transparent;
  border-top: 12px solid #fff;
  bottom: 40px;
  position: absolute;
  right: 43px;
}
.unread {
  text-align: center;
  border-radius: 50%;
  font-size: 14px;
  height: 20px;
  width: 20px;
  position: absolute;
  background: #f24f2d;
  color: #fff;
}
.back-menu {
  font-size: 13px;
  border-radius: 2px;
  position: absolute;
  background: rgba(255, 255, 255, 0.9);
  color: #000;
  width: 80px;
  height: 35px;
  text-align: center;
  line-height: 35px;
  display: none;
}
.voice {
  position: fixed;
  z-index: 1500;
  bottom: 52px;
  left: 0;
  right: 0;
  top: 80px;
  background: rgba(0, 0, 0, 0.8);
}
.close-voice {
  position: absolute;
  bottom: 60px;
  left: 30px;
  display: inline-block;
  height: 50px;
  width: 50px;
  line-height: 50px;
  border-radius: 50%;
  text-align: center;
  background: #fff;
}
</style>
