private with KartenRecords;
private with RueckgabeDatentypen;

package KartenebenenEinstellenLogik is
   pragma Elaborate_Body;

   procedure Kartenebene;
   
private
   
   OrbitHimmel : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'First;
   HimmelOberfläche : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (OrbitHimmel);
   OberUnterfläche : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (HimmelOberfläche);
   UnterOberfläche : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (OberUnterfläche);
   UnterflächeKern : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (UnterOberfläche);
   Standardebenen : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (UnterflächeKern);
   Zufall : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Standardebenen);
   
   KartenebeneAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   Ebene : KartenRecords.KartenebenenVorhandenRecord;
      
   procedure SpeziesTests
     (EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord);
   
   
   
   function KartenebenenTests
     (EingabeExtern : in RueckgabeDatentypen.Kartenebenen_Enum)
      return KartenRecords.KartenebenenVorhandenRecord;

end KartenebenenEinstellenLogik;
