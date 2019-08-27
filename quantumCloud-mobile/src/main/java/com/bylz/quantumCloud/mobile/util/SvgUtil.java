package com.bylz.quantumCloud.mobile.util;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.batik.transcoder.Transcoder;
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
        //File f = new File("e:/test/test.svg");
        File destFile = new File("e:/test/test.png");
        //SvgUtil.convertSVGFile2Png(f, destFile);
        
        String svg = "<svg width=\"250\" height=\"300\" version=\"1.1\" id=\"svgBoard\"><g><line x1=\"50\" y1=\"50\""
                + " x2=\"250\" y2=\"50\" style=\"stroke:#707070;stroke-width:2\"></line><circle cx=\"100\" cy=\"49\""
                + " r=\"16\" fill=\"#00BFF2\" stroke=\"black\" stroke-width=\"2\" onclick=\"clickClassics(this)\">"
                + "</circle><circle cx=\"150\" cy=\"49\" r=\"16\" fill=\"#00BFF2\" stroke=\"black\" stroke-width=\"2\""
                + " onclick=\"clickClassics(this)\"></circle></g><g><line x1=\"50\" y1=\"100\" x2=\"250\" y2=\"100\""
                + " style=\"stroke:#707070;stroke-width:2\"></line><circle cx=\"100\" cy=\"99\" r=\"10\" fill=\"black\""
                + " stroke=\"none\" stroke-width=\"2\" onclick=\"clickClassics(this)\"></circle><circle cx=\"150\""
                + " cy=\"99\" r=\"10\" fill=\"black\" stroke=\"none\" stroke-width=\"2\" onclick=\"clickClassics(this)\">"
                + "</circle></g><g id=\"svg_H\" transform=\"translate(80,29)\" onclick=\"dblclickDoor(this)\"><rect"
                + " fill=\"#22a5de\" width=\"40\" height=\"40\" style=\"stroke:none;\"></rect><path fill=\"#fff\""
                + " d=\"M21.09,37.55l3.43-17.73h2.57l-1.43,7.53h7.15l1.48-7.53h2.57L33.43,37.55H30.86l1.48-7.77H25l-1.38,7.77Zm0,0\""
                + " transform=\"translate(-8.97 -8.69)\"></path></g><g id=\"svg_Measure\" transform=\"translate(130,29)\""
                + " onclick=\"dblclickDoor(this)\"><rect fill=\"#eb6666\" width=\"40\" height=\"40\" style=\"stroke:black;stroke-width:2\">"
                + "</rect><path fill=\"#fff\" d=\"M31,26.6l.41-1.24.93.31-.62-3.06L29.34,24.7l1,.31-.5,1.52h-.48c-6.13,0-11.1,3.33-11.1,"
                + "7.42H20c0-3.19,4.2-5.81,9.33-5.82L27.38,34l1.15,0,1.92-5.78c4.63.35,8.26,2.81,8.26,5.78h1.73c0-3.72-4.11-6.81-9.47-7.34Zm0,0\""
                + " transform=\"translate(-9.34 -8.29)\"></path></g></svg>";
        SvgUtil.convertSVGString2Png(svg.replaceAll("fill=\"black\"", "fill=\"none\""), destFile);
    }
}
