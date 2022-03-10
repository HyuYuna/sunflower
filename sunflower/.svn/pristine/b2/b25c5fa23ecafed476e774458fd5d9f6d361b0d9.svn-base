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
package org.springframework.social.line.api.v2;

import java.util.List;

import org.springframework.social.line.api.v2.response.IdToken;
import org.springframework.social.line.api.v2.response.LineAccessToken;

/**
 * <p>LINE v2 API Access</p>
 */
public interface LineAPIService {

	public static final String GRANT_TYPE_AUTHORIZATION_CODE = "authorization_code";
	public static final String GRANT_TYPE_REFRESH_TOKEN = "refresh_token";

    public LineAccessToken getAccessToken(String code);
    public IdToken idToken(String id_token) ;

    public String getLineWebLoginUrl(String state, String nonce, List<String> scopes) ;

    public boolean verifyIdToken(String id_token, String nonce);

}
