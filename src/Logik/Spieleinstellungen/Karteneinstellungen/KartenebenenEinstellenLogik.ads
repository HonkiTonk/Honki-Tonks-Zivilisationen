private with KartenRecords;
private with RueckgabeDatentypen;

package KartenebenenEinstellenLogik is
   pragma Elaborate_Body;

   procedure Kartenebene;
   
private
   
   KartenebeneAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   Ebene : KartenRecords.KartenebenenVorhandenRecord;
      
   procedure SpeziesTests
     (EbenenExtern : in KartenRecords.KartenebenenVorhandenRecord);
   
   
   
   function KartenebenenTests
     (EingabeExtern : in RueckgabeDatentypen.Kartenebenen_Enum)
      return KartenRecords.KartenebenenVorhandenRecord;

end KartenebenenEinstellenLogik;
