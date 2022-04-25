pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecordKonstanten;

package body KartenpoleKorrigieren is

   function KartenpoleKorrigieren
     return KartenRecords.KartenpoleKorrekturRecord
   is begin
      
      case
        Karten.Kartenparameter.Kartenpole.YAchseNorden
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            SchleifenkorrekturNorden := 0;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            SchleifenkorrekturNorden := KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße);
      end case;
      
      case
        Karten.Kartenparameter.Kartenpole.YAchseSüden
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            SchleifenkorrekturSüden := 0;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            SchleifenkorrekturSüden := KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße);
      end case;
      
      case
        Karten.Kartenparameter.Kartenpole.XAchseWesten
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            SchleifenkorrekturWesten := 0;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            SchleifenkorrekturWesten := KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße);
      end case;
      
      case
        Karten.Kartenparameter.Kartenpole.XAchseOsten
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            SchleifenkorrekturOsten := 0;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            SchleifenkorrekturOsten := KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße);
      end case;
      
      return (SchleifenkorrekturNorden, SchleifenkorrekturSüden, SchleifenkorrekturWesten, SchleifenkorrekturOsten);
      
   end KartenpoleKorrigieren;

end KartenpoleKorrigieren;
