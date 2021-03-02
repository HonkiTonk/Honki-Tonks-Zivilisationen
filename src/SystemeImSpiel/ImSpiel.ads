pragma SPARK_Mode (On);

package ImSpiel is

   function ImSpiel return Integer with
     Post => (ImSpiel'Result >= -1);

private

   AktuellerBefehl : Integer;

end ImSpiel;
