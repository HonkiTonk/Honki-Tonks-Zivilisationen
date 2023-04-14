with StadtRecords;
with SpeziesDatentypen;
with ProduktionDatentypen;
with KartenRecords;
with KartenverbesserungDatentypen;
with StadtArrays;

package StadtGrafikRecords is
   pragma Preelaborate;

   type StadtGrafikRecord is record
      
      SpeziesNummer : StadtRecords.SpeziesStadtnummerRecord;
      
      ID : KartenverbesserungDatentypen.Verbesserung_Stadt_ID_Enum;
      Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
      EinwohnerArbeiter : StadtRecords.EinwohnerArbeiterArray;
      
      Nahrungsmittel : ProduktionDatentypen.Stadtproduktion;
      Nahrungsproduktion : ProduktionDatentypen.Stadtproduktion;
      Produktionrate : ProduktionDatentypen.Stadtproduktion;
      Geldgewinnung : ProduktionDatentypen.Stadtproduktion;
      
      Forschungsrate : ProduktionDatentypen.Stadtproduktion;
      Bauprojekt : StadtRecords.BauprojektRecord;
      Bauzeit : ProduktionDatentypen.Produktion;

      Korruption : ProduktionDatentypen.Stadtproduktion;
      
      GebäudeVorhanden : StadtArrays.GebäudeArray;
      
      UmgebungBewirtschaftung : StadtRecords.UmgebungBewirtschaftungArray;
      
   end record;
   
   
   
   type StadtkarteGrafikRecord is record
      
      Spezies : SpeziesDatentypen.Spezies_Enum;
      
      Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
      
      GebäudeVorhanden : StadtArrays.GebäudeArray;
      
   end record;
   
   
   
   type StadtumgebungGrafikRecord is record
      
      SpeziesNummer : StadtRecords.SpeziesStadtnummerRecord;
                  
      Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
      
      UmgebungBewirtschaftung : StadtRecords.UmgebungBewirtschaftungArray;
      
   end record;
   
   
   
   type BaumenüGrafikRecord is record
      
      Spezies : SpeziesDatentypen.Spezies_Enum;
      
      Bauprojekt : StadtRecords.BauprojektRecord;
      Bauzeit : ProduktionDatentypen.Produktion;
      
   end record;

end StadtGrafikRecords;
