package local.cms.web.util;

import java.io.UnsupportedEncodingException;

import org.apache.commons.codec.binary.Base64;

import local.cms.web.models.Post;

public class CustomUtil {

	public static Post converStringfromByte(Post post) {
		byte[] encodeBase64 = Base64.encodeBase64(post.getImage());

		String base64Encoded = null;
		try {
			base64Encoded = new String(encodeBase64, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			System.err.println(" Error " + e.getMessage());
		}
		post.setImageSrc(base64Encoded);
		return post;
	}
}
