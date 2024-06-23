<?php

$envFilepath = "/volume1/Web/ext-settings/settings.conf";

if($_POST["ext4_warning"]){

    $ext4_warning = isset($_POST['ext4_warning']) ? $_POST['ext4_warning'] : 90;
    $ext4_limit = isset($_POST['ext4_limit']) ? $_POST['ext4_limit'] : 95;
    $btrfs_free_limit = isset($_POST['btrfs_free_limit']) ? $_POST['btrfs_free_limit'] : 5;
    $content = "EXT4_WARNING=".$ext4_warning."\nEXT4_LIMIT=".$ext4_limit."\nBTRFS_FREE_LIMIT=".$btrfs_free_limit;

    file_put_contents($envFilepath, $content);
    $output = shell_exec('sudo /volume1/.@plugins/AppCentral/ext-settings/CONTROL/start-stop.sh start');

}


if (is_file($envFilepath)) {

    $lines = file($envFilepath, FILE_SKIP_EMPTY_LINES|FILE_IGNORE_NEW_LINES);
    foreach($lines as $l) {
        putenv($l);
    }

    $ext4_warning = getenv('EXT4_WARNING');
    $ext4_limit = getenv('EXT4_LIMIT');
    $btrfs_free_limit = getenv('BTRFS_FREE_LIMIT');

}
else
{
    echo "<!--settings not found-->";
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <meta name="robots" content="noindex,nofollow">
    <title>ADM Extended Settings</title>
    <!-- Favicon icon -->
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="./assets/libs/select2/dist/css/select2.min.css">
    <link rel="stylesheet" type="text/css" href="./assets/libs/jquery-minicolors/jquery.minicolors.css">
    <link rel="stylesheet" type="text/css"
          href="./assets/libs/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" type="text/css" href="./assets/libs/quill/dist/quill.snow.css">
    <link href="./dist/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<!-- ============================================================== -->
<!-- Preloader - style you can find in spinners.css -->
<!-- ============================================================== -->
<div class="preloader">
    <div class="lds-ripple">
        <div class="lds-pos"></div>
        <div class="lds-pos"></div>
    </div>
</div>
<!-- ============================================================== -->
<!-- Main wrapper - style you can find in pages.scss -->
<!-- ============================================================== -->
<div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="full"
     data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
    <!-- ============================================================== -->
    <!-- Topbar header - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <header class="topbar" data-navbarbg="skin5">
        <nav class="navbar top-navbar navbar-expand-md navbar-dark">
            <div class="navbar-header" data-logobg="skin5">

                <!-- ============================================================== -->
                <!-- Logo -->
                <!-- ============================================================== -->
                <a class="navbar-brand" href="./">
                    <!-- Logo icon -->
                    <b class="logo-icon ps-2">
                        <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                        <!-- Dark Logo icon -->
                        <img src="./assets/images/icon.png" alt="homepage" style="width:40px" class="light-logo"/>

                    </b>
                    <!--End Logo icon -->
                    <!-- Logo text -->
                    <span class="logo-text">
                            <!-- dark Logo text -->
                            Extended Settings
                        </span>
                    <!-- Logo icon -->
                    <!-- <b class="logo-icon"> -->
                    <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                    <!-- Dark Logo icon -->
                    <!-- <img src="../../assets/images/logo-text.png" alt="homepage" class="light-logo" /> -->

                    <!-- </b> -->
                    <!--End Logo icon -->
                </a>
                <!-- ============================================================== -->
                <!-- End Logo -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Toggle which is visible on mobile only -->
                <!-- ============================================================== -->
                <a class="nav-toggler waves-effect waves-light d-block d-md-none" href="javascript:void(0)"><i
                        class="ti-menu ti-close"></i></a>
            </div>
            <!-- ============================================================== -->
            <!-- End Logo -->
            <!-- ============================================================== -->
            <div class="navbar-collapse collapse" id="navbarSupportedContent" data-navbarbg="skin5">
                <!-- ============================================================== -->
                <!-- toggle and nav items -->
                <!-- ============================================================== -->
                <ul class="navbar-nav float-start me-auto">
                    <li class="nav-item d-none d-lg-block"><a
                            class="nav-link sidebartoggler waves-effect waves-light" href="javascript:void(0)"
                            data-sidebartype="mini-sidebar"><i class="mdi mdi-menu font-24"></i></a></li>
                    <!-- ============================================================== -->
                    <!-- create new -->
                    <!-- ============================================================== -->

                    <!-- ============================================================== -->
                    <!-- Search -->
                    <!-- ============================================================== -->

                </ul>
                <!-- ============================================================== -->
                <!-- Right side toggle and nav items -->
                <!-- ============================================================== -->

            </div>
        </nav>
    </header>
    <!-- ============================================================== -->
    <!-- End Topbar header -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- Left Sidebar - style you can find in sidebar.scss  -->
    <!-- ============================================================== -->
    <aside class="left-sidebar" data-sidebarbg="skin5">
        <!-- Sidebar scroll-->
        <div class="scroll-sidebar">
            <!-- Sidebar navigation-->
            <nav class="sidebar-nav">
                <ul id="sidebarnav" class="pt-4">
                    <li class="sidebar-item"><a class="sidebar-link waves-effect waves-dark sidebar-link"
                                                href="./" aria-expanded="false"><i
                            class="mdi mdi-view-dashboard"></i><span
                            class="hide-menu">Configuration</span></a></li>

                    </li>

                </ul>
            </nav>
            <!-- End Sidebar navigation -->
        </div>
        <!-- End Sidebar scroll-->
    </aside>
    <!-- ============================================================== -->
    <!-- End Left Sidebar - style you can find in sidebar.scss  -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- Page wrapper  -->
    <!-- ============================================================== -->
    <div class="page-wrapper">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="page-breadcrumb">
            <div class="row">
                <div class="col-12 d-flex no-block align-items-center">
                    <h4 class="page-title">Configuration</h4>

                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- End Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Container fluid  -->
        <!-- ============================================================== -->
        <div class="container-fluid">
            <!-- ============================================================== -->
            <!-- Start Page Content -->
            <!-- ============================================================== -->
            <div class="row">
                <div class="col-md-3">
                    <div class="card">
                    <form method="post" class="form-horizontal" data-bitwarden-watching="1">
                        <div class="card-body">
                            <h5 class="card-title">Disk Threshold</h5>
                            <div class="row mb-3 align-items-center">
                                <div class="col-lg-8 col-md-12 text-end">
                                    <span>Ext4 disk space warning</span>
                                </div>
                                <div class="col-lg-4 col-md-12">
                                    <div class="input-group">
                                        <input type="number" name="ext4_warning" class="form-control" placeholder="90"  min="0" max="100"
                                               aria-label="Ext4 disk space limit warning" aria-describedby="basic-addon2" value="<?php echo $ext4_warning; ?>">
                                        <div class="input-group-append">
                                            <span class="input-group-text">%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mb-3 align-items-center">
                                <div class="col-lg-8 col-md-12 text-end">
                                    <span>Ext4 disk space limit</span>
                                </div>
                                <div class="col-lg-4 col-md-12">
                                    <div class="input-group">
                                        <input type="number" name="ext4_limit"  class="form-control" placeholder="95"   min="0" max="100"
                                               aria-label="Ext4 disk space limit" aria-describedby="basic-addon2" value="<?php echo $ext4_limit; ?>">
                                        <div class="input-group-append">
                                            <span class="input-group-text">%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mb-3 align-items-center">
                                <div class="col-lg-8 col-md-12 text-end">
                                    <span>BTRFS Free disk space limit</span>
                                </div>
                                <div class="col-lg-4 col-md-12">
                                    <div class="input-group">
                                        <input type="number" name="btrfs_free_limit"  class="form-control" placeholder="5" min="1" max="100"
                                               aria-label="BTRFS free disk space limit" aria-describedby="basic-addon2" value="<?php echo $btrfs_free_limit; ?>">
                                        <div class="input-group-append">
                                            <span class="input-group-text">%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="border-top">
                            <div class="card-body">
                                <button type="submit" class="btn btn-primary">
                                    Save
                                </button>
                            </div>
                        </div>
                    </form>
                    </div>
                </div>
            </div>
            <!-- editor -->

            <!-- ============================================================== -->
            <!-- End PAge Content -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Right sidebar -->
            <!-- ============================================================== -->
            <!-- .right-sidebar -->
            <!-- ============================================================== -->
            <!-- End Right sidebar -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Container fluid  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- footer -->
        <!-- ============================================================== -->
        <footer class="footer text-center">
        </footer>
        <!-- ============================================================== -->
        <!-- End footer -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Page wrapper  -->
    <!-- ============================================================== -->
</div>
<!-- ============================================================== -->
<!-- End Wrapper -->
<!-- ============================================================== -->
<!-- ============================================================== -->
<!-- All Jquery -->
<!-- ============================================================== -->
<script src="./assets/libs/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap tether Core JavaScript -->
<script src="./assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<!-- slimscrollbar scrollbar JavaScript -->
<script src="./assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
<script src="./assets/extra-libs/sparkline/sparkline.js"></script>
<!--Wave Effects -->
<script src="./dist/js/waves.js"></script>
<!--Menu sidebar -->
<script src="./dist/js/sidebarmenu.js"></script>
<!--Custom JavaScript -->
<script src="./dist/js/custom.min.js"></script>
<!-- This Page JS -->
<script src="./assets/libs/inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>
<script src="./dist/js/pages/mask/mask.init.js"></script>
<script src="./assets/libs/select2/dist/js/select2.full.min.js"></script>
<script src="./assets/libs/select2/dist/js/select2.min.js"></script>
<script src="./assets/libs/jquery-asColor/dist/jquery-asColor.min.js"></script>
<script src="./assets/libs/jquery-asGradient/dist/jquery-asGradient.js"></script>
<script src="./assets/libs/jquery-asColorPicker/dist/jquery-asColorPicker.min.js"></script>
<script src="./assets/libs/jquery-minicolors/jquery.minicolors.min.js"></script>
<script src="./assets/libs/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<script src="./assets/libs/quill/dist/quill.min.js"></script>
<script>
    //***********************************//
    // For select 2
    //***********************************//
    $(".select2").select2();

    /*colorpicker*/
    $('.demo').each(function () {
        //
        // Dear reader, it's actually very easy to initialize MiniColors. For example:
        //
        //  $(selector).minicolors();
        //
        // The way I've done it below is just for the demo, so don't get confused
        // by it. Also, data- attributes aren't supported at this time...they're
        // only used for this demo.
        //
        $(this).minicolors({
            control: $(this).attr('data-control') || 'hue',
            position: $(this).attr('data-position') || 'bottom left',

            change: function (value, opacity) {
                if (!value) return;
                if (opacity) value += ', ' + opacity;
                if (typeof console === 'object') {
                    console.log(value);
                }
            },
            theme: 'bootstrap'
        });

    });
    /*datwpicker*/
    jQuery('.mydatepicker').datepicker();
    jQuery('#datepicker-autoclose').datepicker({
        autoclose: true,
        todayHighlight: true
    });
    var quill = new Quill('#editor', {
        theme: 'snow'
    });

</script>
</body>

</html>