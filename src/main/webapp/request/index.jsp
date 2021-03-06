<%@ page language="java" contentType="text/html; charset=UTF-8" session="false" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="baseURL" value='<%= System.getenv("CANFAR_WEB_HOST") %>' />

<!-- Default to current host. -->
<c:if test="${empty baseURL}">
  <c:set var="req" value="${pageContext.request}" />
  <c:set var="url">${req.requestURL}</c:set>
  <c:set var="uri" value="${req.requestURI}" />
  <c:set var="baseURL" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}" />
</c:if>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/" />

    <c:import url="${baseURL}/canfar/includes/_page_top_styles.shtml" />
    <link rel="stylesheet" type="text/css"
          href="<c:out value=" ${baseURL}/citation/css/citation.css " />" media="screen"
    />
    <link rel="stylesheet" type="text/css"
          href="<c:out value=" ${baseURL}/cadcVOTV/css/jquery-ui-1.11.4.min.css " />" media="screen"
    />

    <!-- Located in ROOT.war -->
    <script type="application/javascript" src="${baseURL}/citation/js/jquery-2.2.4.min.js"></script>
    <script type="application/javascript" src="${baseURL}/citation/js/bootstrap.min.js"></script>

    <!--[if lt IE 9]>
        <script src="/html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <title>Data Citation</title>
  </head>

  <body>
    <c:import url="${baseURL}/canfar/includes/_application_header.shtml" />
    <div class="container-fluid fill">
      <div class="row fill">
        <div role="main" class="col-sm-12 col-md-12 main fill">
          <div class="inner fill">
            <section id="main_content" class="fill">

              <h2 class="doi-page-header">
                <a id="canfar-doi" class="anchor" href="#canfar-doi" aria-hidden="true">
                  <span aria-hidden="true" class="octicon octicon-link"></span>
                </a>Data Citation
              </h2>

              <div class="doi-authenticated hidden">
                <div id="doi_request" class="panel panel-default doi-panel">
                  <div class="panel-heading doi-panel-heading"><h4>DOI Request</h4>
                  </div>
                  <div class="progress doi-progress-bar-container">
                    <div class="progress-bar progress-bar-success doi-progress-bar"
                         role="progressbar" aria-valuenow="100" aria-valuemin="100" aria-valuemax="100">
                    </div>
                  </div>
                  <div class="panel-body doi-panel-body">

                    <!-- Noficiation and Alert bars -->
                    <div class="alert alert-danger hidden">
                      <strong id="status_code">444</strong>&nbsp;&nbsp;<span id="error_msg">Server error</span>
                    </div>

                    <div class="alert alert-success hidden">
                      <span id="alert_msg"></span>
                    </div>

                    <!-- Form starts -->
                    <div class="doi-form-body">
                      <form id="doi_request_form" class="form-horizontal">
                        <!-- DOI Number -->
                        <div class="form-group doi-form-group">
                          <label for="doi_number" class="col-sm-2 control-label" id="doi_number_label">DOI Number</label>
                          <div class="col-sm-3">
                            <input type="text" class="form-control" id="doi_number" name="doi-number"
                                   placeholder="YY.####" readonly
                            />
                          </div>
                        </div>

                        <!-- Publication Title -->
                        <div class="form-group">
                          <label for="doi_title" class="col-sm-2 control-label" id="doi_title_label">Title</label>
                          <div class="col-sm-9">
                            <input type="text" class="form-control" id="doi_title" name="title"
                                   placeholder="title" tabindex="1" required/>
                          </div>
                        </div>

                        <!-- Author List -->
                        <div class="form-group">
                          <label for="doi_creator_list" class="col-sm-2 control-label" id="doi_first_name_label">Author List</label>
                          <div class="col-sm-5">
                            <textarea class="form-control" id="doi_creator_list" name="creatorList"
                                      placeholder="last name, first name" tabindex="2" rows="4" required></textarea>
                          </div>
                        </div>

                        <!-- Publisher -->
                        <div class="form-group">
                          <label for="doi_publisher" class="col-sm-2 control-label" id="doi_publisher_label">Publisher</label>
                          <div class="col-sm-8">
                            <input type="text" class="form-control" id="doi_publisher" name="publisher"
                                   placeholder="publisher name or DOI" tabindex="3" required/>
                          </div>
                        </div>

                        <!-- Publication Date -->
                        <div class="form-group">
                          <label for="doi_publish_year" class="col-sm-2 control-label" >Publication Year</label>
                          <div class="col-sm-1">
                            <select id="doi_publish_year" name="publicationYear" class="form-control"
                                    tabindex="4">
                            </select>
                          </div>
                        </div>

                        <!-- Buttons -->
                        <div class="form-group">
                          <div class="col-sm-offset-2 col-sm-10">
                            <div class="btn-group" role="group">
                              <button type="submit" class="btn btn-primary" id="doi_form_button" tabindex="5">Create</button>
                              <button type="reset" class="btn btn-default doi-button" id="doi_form_reset_button" tabindex="6">Clear</button>
                              <%--<button type="delete" class="btn btn-danger doi-button" id="doi_form_delete_button">Delete</button>--%>
                            </div>
                          </div>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>

                <!-- DOI Metadata panel -->
                <div id="doi_metadata" class="panel panel-default doi-panel hidden">
                  <div class="panel-heading doi-panel-heading">
                    <h4>DOI Metadata</h4>
                  </div>
                  <div class="panel-body doi-panel-body">
                    <div class="row">
                      <label for="doi_status" class="col-sm-2 control-label text-right " id="doi_status_label">Status</label>
                      <div class="col-sm-10">
                        <span id="doi_status">DRAFT</span>
                      </div>
                    </div>

                    <div class="row">
                      <label for="doi_data_dir" class="col-sm-2 control-label text-right " id="doi_data_dir_label">Data Directory</label>
                      <div class="col-sm-10">
                        <span id="doi_data_dir">data dir</span>
                      </div>
                    </div>

                    <%--<div class="row">--%>
                      <%--<label for="doi_landing_page" class="col-sm-2 control-label text-right " id="doi_landing_page_label">URL</label>--%>
                      <%--<div class="col-sm-10">--%>
                        <%--<span id="doi_landing_page">url</span>--%>
                      <%--</div>--%>
                    <%--</div>--%>
                  </div>
                </div>
              </div>

              <div class="doi-anonymous">
                <div class="info-panel card panel-default">
                  <div class="card-body">
                    <span class="info-span"></span>
                  </div>
                </div>
              </div>


              <!-- Info/Error Modal -->
              <!-- Displayed when anything other than a 401 or 200 is returned -->
              <div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title" id="infoModalLongTitle"></h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                      </button>
                    </div>
                    <div class="modal-body">
                      <span class="info-span"></span>
                    </div>
                    <div id="infoThanks" class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Thanks</button>
                    </div>
                  </div>
                </div>
              </div>
              <!-- Content ends -->
            </section>
          </div>
        </div>
      </div>
    </div>

    <script type="text/javascript" src="http://apps.canfar.net/cadcJS/javascript/org.opencadc.js"></script>
    <script type="text/javascript" src="http://apps.canfar.net/cadcJS/javascript/cadc.uri.js"></script>
    <script type="text/javascript" src="http://apps.canfar.net/canfar/javascript/cadc.user.js"></script>
    <script type="application/javascript" src="<c:out value=" ${baseURL}/citation/js/registry-client.js" />"></script>
    <script type="application/javascript" src="<c:out value=" ${baseURL}/citation/js/citation.js" />"></script>

    <script type="application/javascript">
      $(document).ready(function() {

        userManager = new cadc.web.UserManager();

        // From cadc.user.js. Listens for when user logs in
        userManager.subscribe(cadc.web.events.onUserLoad,
            function (event, data)
            {
              // Check to see if user is logged in or not
              if (typeof(data.error) != "undefined") {
                var errorMsg = "";
                if (data.errorStatus === 401) {
                  errorMsg = "<em>" + data.errorStatus + " " + data.error + "</em>. Please log in to use this service.";
                } else {
                  errorMsg = "Unable to access Data Citation " + data.errorStatus + " " + data.error ;
                }
                citation_js.setNotAuthenticated(errorMsg);
              } else {
                citation_js.setAuthenticated();
              }
            });

        // This function is in cadc.user.js, will throw the event
        // in the userManager.subscribe above...
        userManager.loadCurrent();

        // Instantiate controller for Data Citation UI page
        citation_js = new cadc.web.citation.Citation();
        citation_js.setBaseUrl("<c:out value="${baseURL}"/>");

//        citation_js.subscribe(cadc.web.citation.events.onRegistryReady,
//            function(e, data)
//            {
//              citation_js.setAuthenticated();
//            });

      });

    </script>

  </body>

</html>

