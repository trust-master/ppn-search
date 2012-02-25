<?php include('assets/includes/header.php'); ?>
            <div id="content">
                <h2>Company: Rotor Rooter Inc.</h2>
                <div class="col-a col">
                    <div class="sidebar-nav">
                        <ul>
                            <li class="active"><a href="/basic-info.php">Basic Info</a></li>
                            <li><a href="/service-info.php">Service Info</a></li>
                            <li><a href="/credentials.php">Credentials</a></li>
                            <li><a href="/alerts.php">Alerts</a></li>
                            <li><a href="/discounts.php">Discounts</a></li>
                        </ul>
                    </div><!-- closes sidebar nav -->
                </div><!-- closes col a -->
                <div class="col-b col">
                    <form action="">
                        <fieldset>
                            <h3>Company Name</h3>
                            <ul>
                                <li>
                                    <label >Company Name</label>
                                    <input type="text" />
                                </li>
                                <li>
                                    <label >In Business Since</label>
                                    <input type="text" value="Year" />
                                </li>
                            </ul>
                        </fieldset>

                        <fieldset>
                             <h3>Contact Info</h3>
                             <ul>
                                 <li>
                                     <label>Company Email</label>
                                     <input type="text" />
                                 </li>
                                 <li>
                                     <label>Main</label>
                                     <input type="text" value="Phone" />
                                 </li>
                                 <li>
                                     <label>Mobile</label>
                                     <input type="text" value="Phone" />
                                 </li>
                                 <li>
                                     <label>Fax</label>
                                     <input type="text" value="Phone" />
                                 </li>
                             </ul>
                         </fieldset>

                         <fieldset>
                              <h3>Website</h3>
                              <ul>
                                  <li>
                                      <label>Website</label>
                                      <input type="text" value="http://" />
                                  </li>

                              </ul>
                          </fieldset>

                          <fieldset>
                               <h3>Address</h3>
                               <ul>
                                   <li>
                                       <label>City</label>
                                       <input type="text" />
                                   </li>
                                   <li>
                                       <label>State</label>
                                       <input type="text" />
                                   </li>
                                   <li>
                                       <label>Zip</label>
                                       <input type="text" />
                                   </li>
                                   <li class="select-wrap-container">
                                       <label>Country</label>
                                       <div class="select-wrap">
                                           <select name="" id="select-country" class="styled">
                                                <option value="Country">Country</option>
                                           </select>
                                       </div>
                                       <div class="clear"></div>
                                   </li>
                                   <li>
                                    <a href="" class="add">Add a Location</a>
                                   </li>
                               </ul>
                           </fieldset>
                           <fieldset>
                                <h3>Admin</h3>
                                <ul>
                                    <li>
                                        <label>Admin Email</label>
                                        <span class="current-data">Jim.phelps@gmail.com <a href="">[edit]</a></span>
                                    </li>
                                    <li>
                                     <a href="" class="add">Add an Account Admin</a>
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
