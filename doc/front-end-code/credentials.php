<?php include('assets/includes/header.php'); ?>
            <div id="content">
                <h2>Company: Rotor Rooter Inc.</h2>
                <div class="col-a col">
                    <div class="sidebar-nav">
                        <ul>
                            <li><a href="">Basic Info</a></li>
                            <li ><a href="">Service Info</a></li>
                            <li class="active"><a href="">Credentials</a></li>
                            <li><a href="">Alerts</a></li>
                            <li><a href="">Discounts</a></li>
                        </ul>
                    </div><!-- closes sidebar nav -->
                </div><!-- closes col a -->
                <div class="col-b col">
                    <form action="">
                        <fieldset>
                            <h3>Insurance</h3>
                            <ul>
                                <li class="radio-options radio-options-alt">

                                    <label class="btn-label">Insurance</label>
                                    <div class="radio radio2">               
                                       <input type="radio" id="radio-insurance1" name="insurance" />
                                       <label for="radio-insurance1">Yes</label>
                                       <input type="radio" id="radio-insurance2" name="insurance" checked="checked" />
                                       <label for="radio-insurance2">No</label>            
                                    </div>
                                    
                                </li>
                                <li>
                                    <label>Certificate of Insurance</label>
                                    <input type="file" />
                                </li>
                                <li class="date-span">
                                    <label >Expiration</label>
                                    <div class="select-wrap">
                                        <select name="" id="select-month1" class="styled">
                                            <option value="">Choose Month</option>
                                            <option value="">January</option>
                                        </select>
                                    </div>
                                    <input type="text" value="year" />
                                    <span>to</span>
                                    <div class="select-wrap">
                                        <select name="" id="select-month2" class="styled">
                                            <option value="">Choose Month</option>
                                            <option value="">January</option>
                                        </select>
                                    </div>
                                    <input type="text" value="year" />
                                    <div class="clear"></div>
                                </li>
                                <li class="select-wrap-container">
                                    <label>State Insured</label>
                                    <div class="select-wrap">
                                        <select name="" id="select-state" class="styled">
                                            <option value="">Select State</option>
                                        </select>
                                    </div>
                                    <div class="clear"></div>
                                </li>
                            </ul>
                        </fieldset>
                        
                        <fieldset>
                             <h3>License &amp; Bonding Info</h3>
                             <ul>
                                 <li class="select-wrap-container">
                                     <h4>Personal License/Certificate</h4>
                                     <label>Select License Type</label>
                                     <div class="select-wrap">
                                         <select name="" id="select-license-type1" class="styled">
                                            <option value="">all</option>
                                            <option value="">option2</option>
                                            <option value="">option3</option>
                                         </select>
                                     </div>
                                     <div class="clear"></div>
                                 </li>
                                 <li class="tooltip-wrap">
                                    <label >License #</label>
                                    <input type="text" /><a href="" class='more-info'>What is this?</a>
                                      <!-- tooltip  --> 
                                            <div class="tooltip">
                                                <div class="tooltip-content">
                                                    <a href="" class="tooltip-close">X</a>
                                                    <p>Lorem Ipsum.....</p>
                                                <div class="tooltip-inner"></div><!-- closes tooltip_inner -->
                                                </div>
                                            </div><!-- closes tooltip -->
                                    <!-- closes tooltip -->
                                 </li>
                                 <li>
                                    <input class="submit-license" type="submit" value="Submit" />
                                 </li>
                            </ul>
                             <ul>
                                 <li class="select-wrap-container">
                                     <h4>Business/Contractor/License/Certificate</h4>
                                     <label>Select License Type</label>
                                     <div class="select-wrap">
                                         <select name="" id="select-license-type2" class="styled">
                                            <option value="">all</option>
                                            <option value="">option2</option>
                                            <option value="">option3</option>
                                         </select>
                                     </div>
                                     <div class="clear"></div>
                                 </li>
                                 <li class="tooltip-wrap">
                                    <label >License #</label>
                                    <input type="text" /><a href="" class='more-info'>What is this?</a>
                                      <!-- tooltip  --> 
                                            <div class="tooltip">
                                                <div class="tooltip-content">
                                                    <a href="" class="tooltip-close">X</a>
                                                    <p>Lorem Ipsum continuing on with long text to test the look of this.....</p>
                                                <div class="tooltip-inner"></div><!-- closes tooltip_inner -->
                                                </div>
                                            </div><!-- closes tooltip -->
                                    <!-- closes tooltip -->
                                 </li>
                                 <li>
                                    <input class="submit-license" type="submit" value="Submit" />
                                 </li>
                            </ul>
                         </fieldset>
                         
                         <!-- hidden until submit -->
                         <fieldset class="retrieved-values">
                             <h3>License &amp; Bonding Info</h3>
                             <h4>Personal License/Certificate <a href="">[Change]</a></h4>
                             <ul>
                                <li>
                                    <strong>License name:</strong> Christensan, Galen D.
                                </li>
                                <li>
                                    <strong>License address:</strong> 12201 Nevada Circle
                                </li>
                                <li>
                                    <strong>City,State, Zip:</strong> Champlin, MN 23432
                                </li>
                                <li>
                                    <strong>License Number:</strong> Am239078
                                </li>
                                <li>
                                    <strong>License Status:</strong> ISSUED
                                </li>
                                <li>
                                    <strong>License original issue date::</strong> 7/27/1988
                                </li>
                                <li>
                                    <strong>License expiration date:</strong> 12/27/2010
                                </li>
                                <li>
                                    <strong>Continuing education:</strong> NOT MET
                                </li>
                                <li>
                                    <strong>Continuing education:</strong> NOT MET
                                </li>
                             </ul>
                            <h4>Business/Contractor/License/Certificate <a href="">[Change]</a></h4>
                            <ul>
                                <li><strong>License name:</strong>Christianson Electric Inc.</li>
                                <li><strong>License doing business as:</strong>Christianson Electric Inc.</li>
                                <li><strong>License address:</strong>12201 Nevada Cir</li>
                                <li><strong>City state zip</strong>Champlin, MN 67643</li>
                                <li><strong>License number:</strong>CA23908</li>
                                <li><strong>License Type:</strong>CLASS A ELECTRICAL CONTRACTOR</li>
                                <li><strong>Company structure:</strong>Corporation</li>
                                <li><strong>License Status:</strong> ISSUED</li>
                                <li><strong>License original issue date:</strong>3/2/2005</li>
                                <li><strong>License expiration date:</strong>3/2/2012</li>
                                <li><strong>License print date:</strong>3/2/2008</li>
                                <li><strong>Responsible Person:</strong>Galen D. Christianson</li>
                                <li><strong>Responsible Person license #:</strong>WK9879</li>
                                <li><strong>Contractor's phone number:</strong>763-323-9876</li>
                                <li><strong>Enforcement action:</strong>Nos</li>
                            </ul>
                         </fieldset>
                         <!-- .end bonding info  -->
                         
                         <fieldset>
                              <h3>Business Status</h3>
                              <ul>
                                  <li class="select-wrap-container">
                                      <label>Select License Type</label>
                                      <div class="select-wrap">
                                          <select name="" id="select-license-type3" class="styled">
                                             <option value="">all</option>
                                             <option value="">option2</option>
                                             <option value="">option3</option>
                                          </select>
                                      </div>
                                      <div class="clear"></div>
                                  </li>
                                  <li class="tooltip-wrap">
                                     <label >Filing Number</label>
                                     <input type="text" /><a href="" class='more-info'>What is this?</a>
                                       <!-- tooltip  --> 
                                             <div class="tooltip">
                                                 <div class="tooltip-content">
                                                     <a href="" class="tooltip-close">X</a>
                                                     <p>Lorem Ipsum.....</p>
                                                 <div class="tooltip-inner"></div><!-- closes tooltip_inner -->
                                                 </div>
                                             </div><!-- closes tooltip -->
                                     <!-- closes tooltip -->
                                  </li>
                                  <li>
                                     <input class="submit-license" type="submit" value="Submit" />
                                  </li>
                             </ul>
                         </fieldset>
                         
                         <fieldset>
                              <h3>Business Status <a href="">[Change]</a></h3>
                              <div class="business-status-info">
                                    <div class="bsi-col1 retrieved-values">
                                        <ul>
                                            <li><strong>Filing Number:</strong> 1160071-2</li>
                                            <li><strong>Original Date of Filing:</strong> 12/27/2004</li>
                                            <li><strong>Chapter:</strong> 302A</li>
                                            <li><strong>Duration:</strong> Perpetual</li>
                                            <li><strong>Name: </strong>Chritianson Electric, Inc. </li>
                                            <li><strong>Registered Office:</strong> 122201 Nevada Circle</li>
                                            <li><strong>Address:</strong> Champlin, MN 55316</li>
                                            <li><strong>Agent Name:</strong>  No Agent Filed</li>
                                            <li><strong>Entity Type:</strong>  Domestic Corporation</li>
                                            <li><strong>Entity Status:</strong> Active</li>
                                            <li><strong>Good Standing:</strong> 2011</li>
                                            <li>(date of last annual filing)</li>
                                        </ul>
                                    </div>
                                    <div class="bsi-col2"></div>
                              </div>
                         </fieldset>
                         
                         <fieldset>
                            <h3>Affiliations</h3>
                            <ul>
                                <li>
                                    <label>Affiliation Name</label>
                                    <input type="text" />
                                </li>
                                <li>
                                    <label>Title</label>
                                    <input type="text" />
                                </li>
                                <li>
                                    <label>Time Period</label>
                                    <input type="checkbox" />
                                    <label>I am a current Member</label>
                                </li>
                                <li class="date-span">
                                    <label >Expiration</label>
                                    <div class="select-wrap">
                                        <select name="" id="select-month3" class="styled">
                                            <option value="">Choose Month</option>
                                            <option value="">January</option>
                                        </select>
                                    </div>
                                    <input type="text" value="year" />
                                    <span>to</span>
                                    <div class="select-wrap">
                                        <select name="" id="select-month4" class="styled">
                                            <option value="">Choose Month</option>
                                            <option value="">January</option>
                                        </select>
                                    </div>
                                    <input type="text" value="year" />
                                    <div class="clear"></div>
                                </li>
                                <li>
                                    <label>Url</label>
                                    <input type="text" />
                                </li>
                                <li>
                                    <label>Description</label>
                                    <textarea cols="30" rows="10"></textarea>
                                </li>
                                <li>
                                    <a href="" class="add">Add an Affiliation</a>
                                </li>
                            </ul>
                         </fieldset>
                         <fieldset>
                             <h3>Associations</h3>
                             <ul>
                                 <li>
                                     <label>Affiliation Name</label>
                                     <input type="text" />
                                 </li>
                                 <li>
                                     <label>Title</label>
                                     <input type="text" />
                                 </li>
                                 <li>
                                     <label>Time Period</label>
                                     <input type="checkbox" />
                                     <label>I am a current Member</label>
                                 </li>
                                 <li class="date-span">
                                     <label >Expiration</label>
                                     <div class="select-wrap">
                                         <select name="" id="select-month5" class="styled">
                                             <option value="">Choose Month</option>
                                             <option value="">January</option>
                                         </select>
                                     </div>
                                     <input type="text" value="year" />
                                     <span>to</span>
                                     <div class="select-wrap">
                                         <select name="" id="select-month6" class="styled">
                                             <option value="">Choose Month</option>
                                             <option value="">January</option>
                                         </select>
                                     </div>
                                     <input type="text" value="year" />
                                     <div class="clear"></div>
                                 </li>
                                 <li>
                                     <label>Url</label>
                                     <input type="text" />
                                 </li>
                                 <li>
                                     <label>Description</label>
                                     <textarea cols="30" rows="10"></textarea>
                                 </li>
                                 <li>
                                     <a href="" class="add">Add an Association</a>
                                 </li>
                             </ul>
                          </fieldset>
                          <fieldset>
                                <h3>Certifications</h3>
                                <ul>
                                    <li>
                                        <label>Certification Name</label>
                                        <input type="text" />
                                    </li>
                                    <li>
                                        <label>Title</label>
                                        <input type="text" />
                                    </li>
                                    <li>
                                        <label >Certificate</label>
                                        <input type="file" />
                                    </li>
                                    <li>
                                        <label>Description</label>
                                        <textarea cols="30" rows="10"></textarea>
                                    </li>
                                    <li>
                                        <a href="" class="add">Add a Certification</a>
                                    </li>
                                </ul>
                          </fieldset>

                        <fieldset class="last">
                            <a href="" class="cancel">Cancel</a>
                             <input type="submit" value="Save" class="save" />
                         </fieldset>
                    </form>
                </div><!-- closes col b -->
<?php include('assets/includes/footer.php'); ?>
