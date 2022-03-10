/*
 * Copyright 2016 LINE Corporation
 *
 * LINE Corporation licenses this file to you under the Apache License,
 * version 2.0 (the "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at:
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations
 * under the License.
 */
package org.springframework.social.line.api.v2.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Form;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.glassfish.jersey.client.JerseyClientBuilder;
import org.glassfish.jersey.client.JerseyWebTarget;
import org.springframework.social.line.api.v2.LineAPIService;
import org.springframework.social.line.api.v2.response.IdToken;
import org.springframework.social.line.api.v2.response.LineAccessToken;
import org.springframework.stereotype.Service;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * <p>LINE v2 API Access</p>
 */
@Service("lineAPIService")
public class LineAPIServiceImpl extends EgovAbstractServiceImpl implements LineAPIService{

    String charset = "UTF-8";

    private String channelId = "1556720618";

    private String channelSecret = "e49e41b07d664451de45dc3f459dce0b";

    private String callbackUrl = "http://www.junmo.com/lineCallback.do";

    public LineAccessToken getAccessToken(String code) {
    	final String encodedCallbackUrl;

    	try {
            encodedCallbackUrl = URLEncoder.encode(callbackUrl, charset);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }

    	String request = "https://api.line.me/oauth2/v2.1/token";
    	Form form = new Form();
        form.param("grant_type", GRANT_TYPE_AUTHORIZATION_CODE);
        form.param("client_id", channelId);
        form.param("client_secret", channelSecret);
        form.param("redirect_uri", callbackUrl);
        form.param("code", code);

        //JerseyClientBuilder jerseyClientBuilder = new JerseyClientBuilder().register(new LoggingFilter(Logger.getAnonymousLogger(), true));
        JerseyClientBuilder jerseyClientBuilder = new JerseyClientBuilder();
        JerseyWebTarget jerseyWebTarget = jerseyClientBuilder.build().target(request);
        Response response = jerseyWebTarget.request().accept(MediaType.APPLICATION_JSON).post(Entity.form(form));

        LineAccessToken token = response.readEntity(LineAccessToken.class);
        return token;


    }

    public IdToken idToken(String id_token) {
        try {
            DecodedJWT jwt = JWT.decode(id_token);
            return new IdToken(
                    jwt.getClaim("iss").asString(),
                    jwt.getClaim("sub").asString(),
                    jwt.getClaim("aud").asString(),
                    jwt.getClaim("ext").asLong(),
                    jwt.getClaim("iat").asLong(),
                    jwt.getClaim("nonce").asString(),
                    jwt.getClaim("name").asString(),
                    jwt.getClaim("picture").asString());
        } catch (JWTDecodeException e) {
            throw new RuntimeException(e);
        }
    }

    public String getLineWebLoginUrl(String state, String nonce, List<String> scopes) {
        final String encodedCallbackUrl;
        final String scope = strinJoin(scopes, "%20");

        try {
            encodedCallbackUrl = URLEncoder.encode(callbackUrl, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }

        return "https://access.line.me/oauth2/v2.1/authorize?response_type=code"
                + "&client_id=" + channelId
                + "&redirect_uri=" + encodedCallbackUrl
                + "&state=" + state
                + "&scope=" + scope
                + "&nonce=" + nonce;
    }

    static public String strinJoin(List<String> list, String conjunction)
    {
       StringBuilder sb = new StringBuilder();
       boolean first = true;
       for (String item : list)
       {
          if (first)
             first = false;
          else
             sb.append(conjunction);
          sb.append(item);
       }
       return sb.toString();
    }

    public boolean verifyIdToken(String id_token, String nonce) {
        try {
            JWT.require(
                Algorithm.HMAC256(channelSecret))
                .withIssuer("https://access.line.me")
                .withAudience(channelId)
                .withClaim("nonce", nonce)
                .build()
                .verify(id_token);
            return true;
        } catch (UnsupportedEncodingException e) {
            //UTF-8 encoding not supported
            return false;
        } catch (JWTVerificationException e) {
            //Invalid signature/claims
            return false;
        }
    }

}
