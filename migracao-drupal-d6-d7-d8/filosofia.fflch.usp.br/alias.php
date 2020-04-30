<?php

$url = "/home/thiago/repos/scripts/migracao-drupal-d6-d7-d8/filosofia.flch.usp.br/inputs/export_alias.csv";
$csv = file_get_contents($url);
$data = str_getcsv($csv);
foreach($data as $nid=>$path){
  $node = \Drupal::entityTypeManager()->getStorage('node')->load($nid[0]);
  $node->path->alias = $path;
  $node->path->pathauto = Drupal\pathauto\PathautoState::SKIP;
  $node->save();
}
