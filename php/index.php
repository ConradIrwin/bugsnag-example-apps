<?php

require 'vendor/autoload.php';

Bugsnag::register("6015a72ff14038114c3d12623dfb018f");
Bugsnag::notifyError("Broken", "Something broke");

?>