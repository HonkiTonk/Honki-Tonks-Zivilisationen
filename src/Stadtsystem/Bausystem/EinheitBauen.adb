pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleTexte, EinheitenKonstanten, StadtKonstanten;

with LeseEinheitenDatenbank, LeseStadtGebaut;

with EinheitenBeschreibungen, Anzeige;

package body EinheitBauen is

   procedure AnzeigeEinheiten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      EinheitenBeschreibungen.BeschreibungLang (IDExtern => GlobaleDatentypen.EinheitenIDMitNullWert (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer - EinheitenKonstanten.EinheitAufschlag));
      
      New_Line;
      Preis (RasseExtern => StadtRasseNummerExtern.Rasse);
      BauzeitEinheit (StadtRasseNummerExtern => StadtRasseNummerExtern);
      New_Line;
      
      Angriff (RasseExtern => StadtRasseNummerExtern.Rasse);
      Verteidigung (RasseExtern => StadtRasseNummerExtern.Rasse);
      MaximaleLebenspunkte (RasseExtern => StadtRasseNummerExtern.Rasse);
      MaximaleBewegungspunkte (RasseExtern => StadtRasseNummerExtern.Rasse);
      New_Line;
      
      PermanenteKostenEinheiten (RasseExtern => StadtRasseNummerExtern.Rasse);
      
   end AnzeigeEinheiten;
   
   
   
   procedure Preis
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 48,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => RasseExtern,
                                                                                          IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                            - EinheitenKonstanten.EinheitAufschlag))),
                               Width => 1);
      
   end Preis;
   
   
   
   procedure BauzeitEinheit
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 13,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 0
      then
         Ada.Integer_Text_IO.Put (Item  => Positive (GlobaleDatentypen.KostenLager'Last),
                                  Width => 1);
         
      else
         Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                            IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                              - EinheitenKonstanten.EinheitAufschlag))
                                  / LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)),
                                  Width => 1);
      end if;
      
   end BauzeitEinheit;
   
      
   
   procedure Angriff
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 24,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenDatenbank.Angriff (RasseExtern => RasseExtern,
                                                                                 IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                   - EinheitenKonstanten.EinheitAufschlag))),
                               Width => 1);
      
   end Angriff;
   
   
   
   procedure Verteidigung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 25,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Natural (LeseEinheitenDatenbank.Verteidigung (RasseExtern => RasseExtern,
                                                                                      IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                        - EinheitenKonstanten.EinheitAufschlag))),
                               Width => 1);
      
   end Verteidigung;
   
   
   
   procedure MaximaleLebenspunkte
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 14,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => RasseExtern,
                                                                                               IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                                 - EinheitenKonstanten.EinheitAufschlag))),
                               Width => 1);
      
   end MaximaleLebenspunkte;
   
   
   
   procedure MaximaleBewegungspunkte
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                    TextDateiExtern        => GlobaleTexte.Zeug,
                                    ÜberschriftZeileExtern => 0,
                                    ErsteZeileExtern       => 15,
                                    AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                    AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => RasseExtern,
                                                                                                  IDExtern    => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                                    - EinheitenKonstanten.EinheitAufschlag))),
                               Width => 1);
      
   end MaximaleBewegungspunkte;
   
   
   
   procedure PermanenteKostenEinheiten
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      PermanenteEinheitenWerte := False;
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in EinheitStadtRecords.PermanenteKostenArray'Range loop
         
         if
           LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                    IDExtern           => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                      - EinheitenKonstanten.EinheitAufschlag),
                                                    WelcheKostenExtern => PermanenteKostenSchleifenwert)
           > StadtKonstanten.LeerPermanenteKosten
         then
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                          TextDateiExtern        => GlobaleTexte.Zeug,
                                          ÜberschriftZeileExtern => 0,
                                          -- Muss eins kleiner sein als der echte Startwert, da der kleinste Pluswert Eins ist.
                                          ErsteZeileExtern       => 53 + GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum'Pos (PermanenteKostenSchleifenwert),
                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Positive (LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => RasseExtern,
                                                                                                 IDExtern           => GlobaleDatentypen.EinheitenID (Anzeige.AllgemeineAnzeigeText (Anzeige.AktuelleAuswahl).Nummer
                                                                                                   - EinheitenKonstanten.EinheitAufschlag),
                                                                                                 WelcheKostenExtern => PermanenteKostenSchleifenwert)),
                                     Width => 1);
            
            case
              PermanenteEinheitenWerte
            is
               when False =>
                  null;
                  
               when True =>
                  New_Line;
            end case;
            PermanenteEinheitenWerte := not PermanenteEinheitenWerte;
         
         else
            null;
         end if;
         
      end loop PermanenteKostenSchleife;
      
   end PermanenteKostenEinheiten;

end EinheitBauen;
