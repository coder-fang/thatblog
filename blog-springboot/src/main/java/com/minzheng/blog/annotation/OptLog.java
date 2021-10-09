package com.minzheng.blog.annotation;

import java.lang.annotation.*;

/**
 * 操作日志注解
 *
 * @author 11921
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface OptLog {

    /**
     * @return 操作类型
     */
    String optType() default "";

}
