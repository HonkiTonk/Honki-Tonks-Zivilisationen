pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with StadtKonstanten;
with ForschungKonstanten;

with SchreibeWichtiges;
with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;
with LeseWichtiges;

with GebaeudeRichtigeUmgebung;
with StadtProduktion;

package body GebaeudeAllgemein is

   function BeschreibungKurz
     (IDExtern : in EinheitStadtDatentypen.GebäudeIDMitNullwert)
     return Wide_Wide_String
   is begin
      
      case
        IDExtern
      is
         when EinheitStadtDatentypen.GebäudeIDMitNullwert'First =>
            -- Kann hier ein Stopp rein? Wahrscheinlich nicht mit dem aktuellen System, siehe auch den Parametertyp.
            BeschreibungText := SystemKonstanten.LeerUnboundedString;
            
         when others =>
            AktuellerText := 2 * Positive (IDExtern) - 1;
            
            BeschreibungText := GlobaleTexte.Gebäude (AktuellerText);
      end case;
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungKurz;
   
   
   
   function BeschreibungLang
     (IDExtern : in EinheitStadtDatentypen.GebäudeIDMitNullwert)
      return Wide_Wide_String
   is begin
      
      case
        IDExtern
      is
         when EinheitStadtDatentypen.GebäudeIDMitNullwert'First =>
            -- Kann hier ein Stopp rein? Wahrscheinlich nicht mit dem aktuellen System, siehe auch den Parametertyp.
            BeschreibungText := SystemKonstanten.LeerUnboundedString;
            
         when others =>
            AktuellerText := 2 * Positive (IDExtern);
            
            BeschreibungText := GlobaleTexte.Gebäude (AktuellerText);
      end case;
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
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
      VorzeichenWechselExtern : in KartenDatentypen.UmgebungsbereichEins)
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
        LeseGebaeudeDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                             IDExtern    => IDExtern)
        = ForschungKonstanten.ForschungUnmöglich
      then
         return False;
         
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
