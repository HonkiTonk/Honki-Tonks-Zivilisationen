pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;

package KartenkoordinatenWerteLogik is

   type ÜberhangArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of Integer;
     
   type VerschiebungYAchseArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.Kartenform_Y_Einstellbar_Enum;
   VerschiebungNorden : VerschiebungYAchseArray;
   VerschiebungSüden : VerschiebungYAchseArray;
   
   type VerschiebungXAchseArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenDatentypen.Kartenform_X_Einstellbar_Enum;
   VerschiebungWesten : VerschiebungXAchseArray;
   VerschiebungOsten : VerschiebungXAchseArray;

   -- Achsenverschiebung einstellbar machen? äöü
   -- Man kann die Verschiebung doch Abhängig vom Achsenübergang machen, allerdings von der gegenteiligen Achse, wäre das sinnvoll? äöü
   VerschiebungswertYAchse : constant Float := 0.50;
   VerschiebungswertXAchse : constant Float := 0.50;
   
end KartenkoordinatenWerteLogik;
