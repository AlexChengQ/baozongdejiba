package com.bylz.quantumCloud.education.util;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.batik.transcoder.Transcoder;
import org.apache.batik.transcoder.TranscoderException;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.TranscoderOutput;
import org.apache.batik.transcoder.image.PNGTranscoder;

public class SvgUtil
{


    public static void convertSVGString2Png(String svgContent, File png)
            throws IOException
    {
        InputStream in = new   ByteArrayInputStream(svgContent.getBytes("UTF-8"));
        OutputStream out = new FileOutputStream(png);
        out = new BufferedOutputStream(out);
        convert2PNG(in, out);
    }
    
    
    public static void convertSVGFile2Png(File svg, File pdf)
            throws IOException
            {
        InputStream in = new FileInputStream(svg);
        OutputStream out = new FileOutputStream(pdf);
        out = new BufferedOutputStream(out);
        convert2PNG(in, out);
            }

    public static void convert2PNG(InputStream in, OutputStream out)
            throws IOException
    {
        Transcoder tr = new PNGTranscoder();
        try
        {
            TranscoderInput input = new TranscoderInput(in);
            try
            {
                TranscoderOutput output = new TranscoderOutput(out);
                tr.transcode(input, output);
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
            finally
            {
                out.close();
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            in.close();
        }
    }

    public static void main(String[] args) throws IOException
    {
        File f = new File("e:/test.svg");
        File destFile = new File("e:/test.png");
        SvgUtil svgUtil = new SvgUtil();
        svgUtil.convertSVGFile2Png(f, destFile);
    }
}
