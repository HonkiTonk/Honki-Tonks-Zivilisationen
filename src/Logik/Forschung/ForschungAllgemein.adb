pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen; use ForschungenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with TastenbelegungDatentypen;
with GrafikDatentypen;
with SystemDatentypen;
with InteraktionAuswahl;

with SchreibeWichtiges;
with LeseForschungenDatenbank;
with LeseWichtiges;

with EingabeSFML;
with StadtWerteFestlegen;
with StadtUmgebungsbereichFestlegen;
with NachGrafiktask;
with Mausauswahl;

-- Auch mal überarbeiten? äöü
package body ForschungAllgemein is
   
   -- Mal mit der Schleife weiter unten zusammenführen. äöü
   function TechnologieVorhanden
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungIDNichtMöglich)
      return Boolean
   is begin
      
      case
        TechnologieExtern
      is
         when ForschungKonstanten.ForschungUnmöglich =>
            return False;
            
         when ForschungKonstanten.LeerForschungAnforderung =>
            return True;
            
         when others =>
            return LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                            WelcheTechnologieExtern => TechnologieExtern);
      end case;
            
   end TechnologieVorhanden;

   

   procedure Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
         
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      WasErforschtWerdenSoll := AuswahlForschung (RasseExtern => RasseExtern);

      if
        WasErforschtWerdenSoll = ForschungKonstanten.LeerForschungAnforderung
        or
          WasErforschtWerdenSoll = AktuellesForschungsprojekt
      then
         null;
               
      else
         SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                              ForschungIDExtern => WasErforschtWerdenSoll);
      end if;
      
   end Forschung;



   function AuswahlForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDMitNullWert
   is begin

      ForschungSchleife:
      for ForschungenSchleifenwert in ForschungenDatentypen.ForschungID loop
         
         InteraktionAuswahl.MöglicheForschungen (ForschungenSchleifenwert) := ForschungAnforderungErfüllt (RasseExtern       => RasseExtern,
                                                                                                             ForschungIDExtern => ForschungenSchleifenwert);
         
      end loop ForschungSchleife;
      
      return ForschungAuswahlSFML;

   end AuswahlForschung;
   
   
   
   function ForschungAuswahlSFML
     return ForschungenDatentypen.ForschungIDMitNullWert
   is begin
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Forschung_Enum;
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := Mausauswahl.Forschungsmenü;
         NachGrafiktask.AktuelleAuswahl.AuswahlEins := Natural (AktuelleAuswahl);
         
         case
           EingabeSFML.Tastenwert
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = ForschungKonstanten.LeerForschungAnforderung
               then
                  null;
                  
               else
                  GewählteForschung := AktuelleAuswahl;
                  exit AuswahlSchleife;
               end if;
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               GewählteForschung := ForschungKonstanten.LeerForschungAnforderung;
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      
      return GewählteForschung;
      
   end ForschungAuswahlSFML;



   procedure ForschungFortschritt
   is begin
      
      RasseSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when RassenDatentypen.Mensch_Spieler_Enum =>
               FortschrittMensch (RasseExtern => RasseSchleifenwert);
               NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Rundenende_Enum;
               
            when RassenDatentypen.KI_Spieler_Enum =>
               FortschrittKI (RasseExtern => RasseSchleifenwert);
         end case;
               
      end loop RasseSchleife;
      
   end ForschungFortschritt;
   
   
   
   -- Die beiden Forschrittprozeduren zusammenführen? Sinnvoll oder könnte es bei Erweiterungen kompliziert werden? äöü
   -- Soltle recht einfach gehen, benötigt nur eine weitere Prüfung ob das ein Mensch ist. äöü
   procedure FortschrittMensch
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      if
        AktuellesForschungsprojekt = ForschungKonstanten.LeerForschung
      then
         null;
         
      elsif
        LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern) >= LeseForschungenDatenbank.PreisForschung (RasseExtern => RasseExtern,
                                                                                                               IDExtern    => AktuellesForschungsprojekt)
      then
         if
           AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Anfangswert_Enum)
           or
             AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Endwert_Enum)
         then
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegenTechnologie (RasseExtern => RasseExtern);

         else
            null;
         end if;
         
         Forschungserfolg (RasseExtern => RasseExtern);
            
      else
         SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      end if;
      
   end FortschrittMensch;
   
   
   
   procedure Forschungserfolg
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      NachGrafiktask.AktuelleRasse := RasseExtern;
      Auswahl := 1;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Forschung_Efolgreich_Enum;
      
      ErfolgSchleife:
      loop
         
         NachGrafiktask.AktuelleAuswahl.AuswahlEins := Auswahl;
         
         case
           EingabeSFML.Tastenwert
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 Auswahl = 1
               then
                  Auswahl := 2;
                  
               else
                  exit ErfolgSchleife;
               end if;
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               if
                 Auswahl = 2
               then
                  Auswahl := 1;
                  
               else
                  exit ErfolgSchleife;
               end if;
               
            when others =>
               null;
         end case;
         
      end loop ErfolgSchleife;
      
      SchreibeWichtiges.Erforscht (RasseExtern => RasseExtern);
      SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                           ForschungIDExtern => AuswahlForschung (RasseExtern => RasseExtern));
      
      NachGrafiktask.AktuelleRasse := RassenDatentypen.Keine_Rasse_Enum;
      
   end Forschungserfolg;
   
   
   
   procedure FortschrittKI
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      if
        AktuellesForschungsprojekt = ForschungKonstanten.LeerForschung
      then
         null;
         
      elsif
        LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern) >= LeseForschungenDatenbank.PreisForschung (RasseExtern => RasseExtern,
                                                                                                               IDExtern    => AktuellesForschungsprojekt)
      then
         SchreibeWichtiges.Erforscht (RasseExtern => RasseExtern);
         
         if
           AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Anfangswert_Enum)
           or
             AktuellesForschungsprojekt = StadtUmgebungsbereichFestlegen.TechnologieUmgebungsgröße (RasseExtern, SystemDatentypen.Endwert_Enum)
         then
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegenTechnologie (RasseExtern => RasseExtern);

         else
            null;
         end if;
         
         SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                              ForschungIDExtern => ForschungKonstanten.LeerForschung);
            
      else
         null;
      end if;
      
   end FortschrittKI;
   
   
   
   function ForschungAnforderungErfüllt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in ForschungenDatentypen.ForschungID)
      return Boolean
   is begin
   
      case
        LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                 WelcheTechnologieExtern => ForschungIDExtern)
      is
         when True =>
            return False;
         
         when False =>
            null;
      end case;
      
      AnforderungSchleife:
      for AnforderungSchleifenwert in ForschungenDatentypen.AnforderungForschungArray'Range loop
            
         Forschungsanforderungen := LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                   IDExtern                => ForschungIDExtern,
                                                                                   WelcheAnforderungExtern => AnforderungSchleifenwert);
         
         if
           Forschungsanforderungen = ForschungKonstanten.LeerForschungAnforderung
         then
            null;
            
         elsif
           Forschungsanforderungen = ForschungKonstanten.ForschungUnmöglich
         then
            return False;
                  
         elsif
           True = LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                           WelcheTechnologieExtern => Forschungsanforderungen)
         then
            null;
            
         else
            return False;
         end if;
               
      end loop AnforderungSchleife;
      
      return True;
      
   end ForschungAnforderungErfüllt;

end ForschungAllgemein;
