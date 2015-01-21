<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<#if requestAttributes.uiLabelMap??><#assign uiLabelMap = requestAttributes.uiLabelMap></#if>
<#assign useMultitenant = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("general.properties", "multitenant")>

<#assign username = requestParameters.USERNAME?default((sessionAttributes.autoUserLogin.userLoginId)?default(""))>
<#if username != "">
  <#assign focusName = false>
<#else>
  <#assign focusName = true>
</#if>


<div id="login" class="reveal-modal remove-whitespace" data-options="close_on_background_click: false;" data-reveal>
<#assign logo><img src="<@ofbizContentUrl>/images/feather-tiny.png</@ofbizContentUrl>"/></#assign>
<@section title="${uiLabelMap.CommonLogin}">
  <@row>
    <div class="large-12 columns auth-plain">
     <div class="signup-panel right-solid">
      <form method="post" action="<@ofbizUrl>login</@ofbizUrl>" name="loginform">
       <@row>
        <div class="large-12 columns">
          <div class="row collapse">
            <div class="small-3 columns">
              <span class="prefix"><i class="fi-torso-female"></i></span>
            </div>
            <div class="small-9 columns">
              <input type="text" name="USERNAME" value="${username}" size="20" placeholder="admin" title="${uiLabelMap.CommonUsername}" data-tooltip aria-haspopup="true" class="has-tip tip-right" data-options="disable_for_touch:true" />
            </div>
          </div>
        </div>
       </@row>
      <@row>
        <div class="large-12 columns">
          <div class="row collapse">
            <div class="small-3 columns">
              <span class="prefix"><i class="fi-lock"></i></span>
            </div>
            <div class="small-9 columns">
              <input type="password" name="PASSWORD" value="" size="20" placeholder="ofbiz" title="${uiLabelMap.CommonPassword}" data-tooltip aria-haspopup="true" class="has-tip tip-right" data-options="disable_for_touch:true" />
            </div>
          </div>
        </div>
       </@row>
          <#if ("Y" == useMultitenant) >
              <#if !requestAttributes.tenantId??>
              <div class="row">
                <div class="large-12 columns">
                  <div class="row collapse">
                    <div class="small-3 columns">
                      <span class="prefix">${uiLabelMap.CommonTenantId}</span>
                    </div>
                    <div class="small-9 columns">
                      <input type="text" name="tenantId" value="${parameters.tenantId!}" size="20"/>
                    </div>
                  </div>
                </div>
               </div>
              <#else>
                  <input type="hidden" name="tenantId" value="${requestAttributes.tenantId!}"/>
              </#if>
          </#if>
   
         
         <@row>
             <@cell class="large-9 columns text-left">
                <small><a href="<@ofbizUrl>forgotPassword</@ofbizUrl>">${uiLabelMap.CommonForgotYourPassword}?</a></small>
                
             </@cell>
            <@cell class="large-3 columns text-right">
                <input type="hidden" name="JavaScriptEnabled" value="N"/>
                <input type="submit" value="${uiLabelMap.CommonLogin}" class="button"/>
            </@cell>
        </@row>
      </form>
      </div>
    </div>
  </@row>
</@section>
</div>
<script language="JavaScript" type="text/javascript">
  $(function(){
     $(document).foundation();
     $('#login').foundation('reveal', 'open');
    });
  document.loginform.JavaScriptEnabled.value = "Y";
  <#if focusName>
    document.loginform.USERNAME.focus();
  <#else>
    document.loginform.PASSWORD.focus();
  </#if>
</script>
