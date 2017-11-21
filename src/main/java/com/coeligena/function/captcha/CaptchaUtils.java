package com.coeligena.function.captcha;

import com.github.bingoohuang.patchca.color.ColorFactory;
import com.github.bingoohuang.patchca.color.SingleColorFactory;
import com.github.bingoohuang.patchca.custom.ConfigurableCaptchaService;
import com.github.bingoohuang.patchca.filter.predefined.CurvesRippleFilterFactory;
import com.github.bingoohuang.patchca.font.RandomFontFactory;
import com.github.bingoohuang.patchca.service.Captcha;
import com.github.bingoohuang.patchca.word.RandomWordFactory;
import org.springframework.stereotype.Component;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * 验证码
 *
 * <p>
 * Created by Ellery on 2017/11/11.
 */
@Component
public class CaptchaUtils {

    private ConfigurableCaptchaService configurableCaptchaService = null;

    public CaptchaUtils() {

        ColorFactory colorFactory;
        RandomFontFactory fontFactory;
        RandomWordFactory wordFactory;

        configurableCaptchaService = new ConfigurableCaptchaService();

        // 颜色创建工厂
        colorFactory = new SingleColorFactory(new Color(25, 60, 170));
        configurableCaptchaService.setColorFactory(colorFactory);

        // 随机字体生成器
        fontFactory = new RandomFontFactory();
        fontFactory.setMaxSize(32);
        fontFactory.setMinSize(28);
        configurableCaptchaService.setFontFactory(fontFactory);

        // 自定义验证码图片背景
        // CustomBackgroundFactory backgroundFactory = new CustomBackgroundFactory();
        // configurableCaptchaService.setBackgroundFactory(backgroundFactory);

        // 随机字符生成器,去除掉容易混淆的字母和数字,如 o 和 0 等
        wordFactory = new RandomWordFactory();
        wordFactory.setCharacters("abcdefghkmnpqstwxyz23456789");
        wordFactory.setMaxLength(4);
        wordFactory.setMinLength(4);
        configurableCaptchaService.setWordFactory(wordFactory);

        // 图片滤镜设置
        CurvesRippleFilterFactory filterFactory = new CurvesRippleFilterFactory(
                configurableCaptchaService.getColorFactory());
        configurableCaptchaService.setFilterFactory(filterFactory);

        // 验证码图片的大小
        configurableCaptchaService.setWidth(81);
        configurableCaptchaService.setHeight(34);
    }

    public ConfigurableCaptchaService getCCS() {
        return configurableCaptchaService;
    }

    public void getCaptchaAndImage() {
        // 得到验证码对象,有验证码图片和验证码字符串
        Captcha captcha = configurableCaptchaService.getCaptcha();

        // 取得验证码字符串放入Session
        String validationCode = captcha.getChallenge();
        System.out.println(validationCode);

        // 取得验证码图片并输出
        try {
            FileOutputStream fos = new FileOutputStream("captcha.png");
            BufferedImage bufferedImage = captcha.getImage();
            ImageIO.write(bufferedImage, "png", fos);
        } catch(IOException e) {
            e.printStackTrace();
        }
    }

}