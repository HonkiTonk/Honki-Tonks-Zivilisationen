pragma SPARK_Mode (On);

with GlobaleTexte, StadtKonstanten, ForschungKonstanten, EinheitStadtDatentypen;
use EinheitStadtDatentypen;

with SchreibeWichtiges, SchreibeStadtGebaut;
with LeseStadtGebaut, LeseGebaeudeDatenbank, LeseWichtiges;

with Anzeige, GebaeudeRichtigeUmgebung, StadtProduktion;

package body GebaeudeAllgemein is

   procedure BeschreibungKurz
     (IDExtern : in EinheitStadtDatentypen.GebäudeIDMitNullwert)
   is begin
      
      case
        IDExtern
      is
         when EinheitStadtDatentypen.GebäudeIDMitNullwert'First =>
            return;
            
         when others =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Beschreibungen_Gebäude_Kurz,
                                                  TextZeileExtern => Positive (IDExtern));
      end case;
      
   end BeschreibungKurz;
   
   
   
   procedure BeschreibungLang
     (IDExtern : in EinheitStadtDatentypen.GebäudeIDMitNullwert)
   is begin
      
      case
        IDExtern
      is
         when EinheitStadtDatentypen.GebäudeIDMitNullwert'First =>
            null;
            
         when others =>
            Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                          TextDateiExtern        => GlobaleTexte.Beschreibungen_Gebäude_Lang,
                                          ÜberschriftZeileExtern => 0,
                                          ErsteZeileExtern       => Positive (IDExtern),
                                          AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                          AbstandEndeExtern      => GlobaleTexte.Leer);
      end case;
      
   end BeschreibungLang;
   
   

   procedure GebäudeProduktionBeenden
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
   is begin
      
      SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      RessourcenExtern       => StadtKonstanten.LeerStadt.Ressourcen,
                                      ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      BauprojektExtern       => StadtKonstanten.LeerBauprojekt);
      SchreibeStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern     => StadtRasseNummerExtern,
                                             WelchesGebäudeExtern       => IDExtern,
                                             HinzufügenEntfernenExtern  => True);
      
      PermanenteKostenDurchGebäudeÄndern (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                            IDExtern                => IDExtern,
                                            VorzeichenWechselExtern => 1);
                  
   end GebäudeProduktionBeenden;
   
   
   
   procedure GebäudeEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      WelchesGebäudeExtern : in EinheitStadtDatentypen.GebäudeID)
   is begin
      
      SchreibeWichtiges.Geldmenge (RasseExtern         => StadtRasseNummerExtern.Rasse,
                                   GeldZugewinnExtern  => Integer (LeseGebaeudeDatenbank.PreisGeld (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                    IDExtern    => WelchesGebäudeExtern)) / 2,
                                   RechnenSetzenExtern => True);
      SchreibeStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern     => StadtRasseNummerExtern,
                                             WelchesGebäudeExtern      => WelchesGebäudeExtern,
                                             HinzufügenEntfernenExtern => False);
      
      PermanenteKostenDurchGebäudeÄndern (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                            IDExtern                => WelchesGebäudeExtern,
                                            VorzeichenWechselExtern => -1);
      
   end GebäudeEntfernen;
   
   

   procedure PermanenteKostenDurchGebäudeÄndern
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID;
      -- Der Vorzeichenwechsel wird benötigt um auch bei Entfernung von Gebäuden die permanenten Kosten korrekt zu ändern
      VorzeichenWechselExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in EinheitStadtRecords.PermanenteKostenArray'Range loop
         
         SchreibeStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     WelcherPostenExtern    => PermanenteKostenSchleifenwert,
                                                     KostenExtern           => EinheitStadtDatentypen.GesamtePermanenteKosten (VorzeichenWechselExtern)
                                                     * LeseGebaeudeDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                               IDExtern           => IDExtern,
                                                                                               WelcheKostenExtern => PermanenteKostenSchleifenwert),
                                                     ÄndernSetzenExtern    => True);
         
      end loop PermanenteKostenSchleife;
      
      StadtProduktion.StadtProduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end PermanenteKostenDurchGebäudeÄndern;
   
   
   
   -- Hier vielleicht noch Prüfungen einbauen um zu testen ob das Gebäude für diese Rasse überhaupt existiert?
   function GebäudeAnforderungenErfüllt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return Boolean
   is begin
      
      case
        LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                           WelchesGebäudeExtern  => IDExtern)
      is
         when True =>
            return False;
            
         when False =>
            null;
      end case;
      
      case
        GebaeudeRichtigeUmgebung.RichtigeUmgebungVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            GebäudeIDExtern        => IDExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        LeseGebaeudeDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                             IDExtern    => IDExtern)
        = ForschungKonstanten.LeerForschungAnforderung
      then
         null;
         
      elsif
        LeseWichtiges.Erforscht (RasseExtern             => StadtRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => LeseGebaeudeDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                 IDExtern    => IDExtern))
        = True
      then
         null;
      
      else
         return False;
      end if;
      
      return True;
      
   end GebäudeAnforderungenErfüllt;

end GebaeudeAllgemein;
