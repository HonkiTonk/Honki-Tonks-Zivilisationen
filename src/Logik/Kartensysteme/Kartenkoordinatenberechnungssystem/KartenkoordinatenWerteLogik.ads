pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartenartDatentypen;

package KartenkoordinatenWerteLogik is

   type ÜberhangArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of Integer;
     
   type VerschiebungYAchseArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenartDatentypen.Kartenform_Y_Einstellbar_Enum;
   VerschiebungYAchse : VerschiebungYAchseArray;
   
   type VerschiebungXAchseArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenartDatentypen.Kartenform_X_Einstellbar_Enum;
   VerschiebungXAchse : VerschiebungXAchseArray;

   -- Achsenverschiebung einstellbar machen. äöü
   VerschiebungswertYAchse : constant Float := 0.50;
   VerschiebungswertXAchse : constant Float := 0.50;
   
end KartenkoordinatenWerteLogik;
