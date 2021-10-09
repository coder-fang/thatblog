<template>
  <el-card class="main-card">
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <!-- 修改信息 -->
      <el-tab-pane label="修改信息" name="info">
        <div class="info-container">
          <el-upload
            class="avatar-uploader"
            action="/api/users/avatar"
            :show-file-list="false"
            :on-success="updateAvatar"
          >
            <img v-if="avatar" :src="avatar" class="avatar" />
            <i v-else class="el-icon-plus avatar-uploader-icon" />
          </el-upload>
          <el-form
            label-width="70px"
            :model="infoForm"
            style="width:320px;margin-left:3rem"
          >
            <el-form-item label="昵称">
              <el-input v-model="infoForm.nickname" size="small" />
            </el-form-item>
            <el-form-item label="个人简介">
              <el-input v-model="infoForm.intro" size="small" />
            </el-form-item>
            <el-form-item label="个人网站">
              <el-input v-model="infoForm.webSite" size="small" />
            </el-form-item>
            <el-button
              @click="updateInfo"
              type="primary"
              size="medium"
              style="margin-left:4.375rem"
            >
              修改
            </el-button>
          </el-form>
        </div>
      </el-tab-pane>
      <!-- 修改密码 -->
      <el-tab-pane label="修改密码" name="password">
        <el-form label-width="70px" :model="passwordForm" style="width:320px">
          <el-form-item label="旧密码">
            <el-input
              @keyup.enter.native="updatePassword"
              v-model="passwordForm.oldPassword"
              size="small"
              show-password
            />
          </el-form-item>
          <el-form-item label="新密码">
            <el-input
              @keyup.enter.native="updatePassword"
              v-model="passwordForm.newPassword"
              size="small"
              show-password
            />
          </el-form-item>
          <el-form-item label="确认密码">
            <el-input
              @keyup.enter.native="updatePassword"
              v-model="passwordForm.confirmPassword"
              size="small"
              show-password
            />
          </el-form-item>
          <el-button
            type="primary"
            size="medium"
            style="margin-left:4.4rem"
            @click="updatePassword"
          >
            修改
          </el-button>
        </el-form>
      </el-tab-pane>
      <!-- 网站公告 -->
      <el-tab-pane label="修改公告" name="notice">
        <el-input
          v-model="notice"
          placeholder="请输入公告内容"
          style="margin-bottom:1rem"
          type="textarea"
          :rows="5"
        />
        <el-button type="danger" size="medium" @click="updateNotice">
          修改
        </el-button>
      </el-tab-pane>
    </el-tabs>
  </el-card>
</template>

<script>
export default {
  data: function() {
    return {
      infoForm: {
        nickname: this.$store.state.nickname,
        intro: this.$store.state.intro,
        webSite: this.$store.state.webSite
      },
      passwordForm: {
        oldPassword: "",
        newPassword: "",
        confirmPassword: ""
      },
      notice: "",
      activeName: "info"
    };
  },
  methods: {
    handleClick(tab) {
      if (tab.index == 2 && this.notice == "") {
        this.axios.get("/api/admin/notice").then(({ data }) => {
          this.notice = data.data;
        });
      }
    },
    updateAvatar(response) {
      if (response.flag) {
        this.$message.success(response.message);
        this.$store.commit("updateAvatar", response.data);
      } else {
        this.$message.error(response.message);
      }
    },
    updateInfo() {
      if (this.infoForm.nickname.trim() == "") {
        this.$message.error("昵称不能为空");
        return false;
      }
      this.axios.put("/api/users/info", this.infoForm).then(({ data }) => {
        if (data.flag) {
          this.$message.success(data.message);
          this.$store.commit("updateUserInfo", this.infoForm);
        } else {
          this.$message.error(data.message);
        }
      });
    },
    updatePassword() {
      if (this.passwordForm.oldPassword.trim() == "") {
        this.$message.error("旧密码不能为空");
        return false;
      }
      if (this.passwordForm.newPassword.trim() == "") {
        this.$message.error("新密码不能为空");
        return false;
      }
      if (this.passwordForm.newPassword.length < 6) {
        this.$message.error("新密码不能少于6位");
        return false;
      }
      if (this.passwordForm.newPassword != this.passwordForm.confirmPassword) {
        this.$message.error("两次密码输入不一致");
        return false;
      }
      this.axios
        .put("/api/admin/users/password", this.passwordForm)
        .then(({ data }) => {
          if (data.flag) {
            this.passwordForm.oldPassword = "";
            this.passwordForm.newPassword = "";
            this.passwordForm.confirmPassword = "";
            this.$message.success(data.message);
          } else {
            this.$message.error(data.message);
          }
        });
    },
    updateNotice() {
      if (this.notice.trim() == "") {
        this.$message.error("公告不能为空");
        return false;
      }
      let param = new URLSearchParams();
      param.append("notice", this.notice);
      this.axios.put("/api/admin/notice", param).then(({ data }) => {
        if (data.flag) {
          this.$message.success(data.message);
        } else {
          this.$message.error(data.message);
        }
      });
    }
  },
  computed: {
    avatar() {
      return this.$store.state.avatar;
    }
  }
};
</script>

<style scoped>
.avatar-container {
  text-align: center;
}
.el-icon-message-solid {
  color: #f56c6c;
  margin-right: 0.3rem;
}
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 120px;
  height: 120px;
  line-height: 120px;
  text-align: center;
}
.avatar {
  width: 120px;
  height: 120px;
  display: block;
}
.info-container {
  display: flex;
  align-items: center;
  margin-left: 20%;
  margin-top: 5rem;
}
</style>
