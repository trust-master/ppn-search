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
                    <form action="" id="discounts">
                        <fieldset>
                            <a href="" class="add">Add Discount</a>
                            <table>
                                <thead>
                                    <tr>
                                        <th>
                                            <a href=""><span>Discount Name</span></a>
                                        </th>
                                        <th class="sorting">
                                            <a href=""><span>Discount Type</span></a>
                                        </th>
                                        <th>
                                            <a href=""><span>Start Date</span></a>
                                        </th>
                                        <th>
                                            <a href=""><span>End Date</span></a>
                                        </th>
                                        <th class="last">
                                            <a href=""><span>Actions</span></a>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Discount Title 1</td>
                                        <td>Discount Type</td>
                                        <td>10/12/11</td>
                                        <td>10/30/11</td>
                                        <td>
                                            <a href="" class="edit">Edit</a>
                                            <a href="" class="delete">Delete</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Discount Title 2 and a little longer</td>
                                        <td>Discount Type</td>
                                        <td>10/12/11</td>
                                        <td>10/30/11</td>
                                        <td>
                                            <a href="" class="edit">Edit</a>
                                            <a href="" class="delete">Delete</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Discount Title 2 and a little longer</td>
                                        <td>Discount Type</td>
                                        <td>10/12/11</td>
                                        <td>10/30/11</td>
                                        <td>
                                            <a href="" class="edit">Edit</a>
                                            <a href="" class="delete">Delete</a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </fieldset>
                        <fieldset class="last">
                            <a href="" class="cancel">Cancel</a>
                             <input type="submit" value="Save" class="save" />
                         </fieldset>
                    </form>
                </div><!-- closes col b -->
<?php include('assets/includes/footer.php'); ?>
