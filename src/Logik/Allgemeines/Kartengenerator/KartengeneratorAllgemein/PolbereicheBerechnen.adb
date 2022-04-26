pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecordKonstanten;

with Karten;
with KartengeneratorVariablen;

package body PolbereicheBerechnen is

   procedure PolbereicheBerechnen
   is begin
      
      case
        Karten.Kartenparameter.Kartenpole.YAchseNorden
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            PolbereichNorden := 0;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            if
              KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße, KartenDatentypen.Norden_Enum) > Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 2
            then
               PolbereichNorden := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 2;
               
            else
               PolbereichNorden := KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße, KartenDatentypen.Norden_Enum);
            end if;
      end case;
      
      case
        Karten.Kartenparameter.Kartenpole.YAchseSüden
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            PolbereichSüden := 0;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            if
              KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße, KartenDatentypen.Süden_Enum) > Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 2
            then
               PolbereichSüden := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / 2;
               
            else
               PolbereichSüden := KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße, KartenDatentypen.Süden_Enum);
            end if;
      end case;
      
      case
        Karten.Kartenparameter.Kartenpole.XAchseWesten
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            PolbereichWesten := 0;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            if
              KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße, KartenDatentypen.Westen_Enum) > Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 2
            then
               PolbereichWesten := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 2;
               
            else
               PolbereichWesten := KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße, KartenDatentypen.Westen_Enum);
            end if;
      end case;
      
      case
        Karten.Kartenparameter.Kartenpole.XAchseOsten
      is
         when KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum =>
            PolbereichOsten := 0;
            
         when KartenDatentypen.Kartenpol_Vorhanden_Enum =>
            if
              KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße, KartenDatentypen.Osten_Enum) > Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 2
            then
               PolbereichOsten := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / 2;

            else
               PolbereichOsten := KartenRecordKonstanten.Eisrand (Karten.Kartenparameter.Kartengröße, KartenDatentypen.Osten_Enum);
            end if;
      end case;
      
      ------------------ Eventuell kann das noch entfernt werden.
      KartengeneratorVariablen.Polbereiche := (PolbereichNorden, PolbereichSüden, PolbereichWesten, PolbereichOsten);
      
      KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse := Karten.WeltkarteArray'First (2) + KartengeneratorVariablen.Polbereiche.Norden;
      KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse := Karten.WeltkarteArray'First (3) + KartengeneratorVariablen.Polbereiche.Westen;
      
      KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse - KartengeneratorVariablen.Polbereiche.Süden;
      KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse - KartengeneratorVariablen.Polbereiche.Osten;

   end PolbereicheBerechnen;

end PolbereicheBerechnen;
