pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen; use ForschungenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with GlobaleTexte;
with TextnummernKonstanten;
with TastenbelegungDatentypen;
with GrafikDatentypen;
with SystemDatentypen;
with OptionenVariablen;

with SchreibeWichtiges;
with LeseForschungenDatenbank;
with LeseWichtiges;

with Eingabe;
with StadtWerteFestlegen;
with StadtUmgebungsbereichFestlegen;
with NachGrafiktask;
with NachLogiktask;
with InteraktionAuswahl;

with KIForschung;

package body ForschungAllgemein is

   function Beschreibung
     (IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      -- RasseExtern wird später benötigt wenn es verschiedene Forschungsbäume gibt.
      if
        RasseExtern = RassenDatentypen.Menschen_Enum
      then
         null;

      else
         null;
      end if;
      
      case
        IDExtern
      is
         when ForschungKonstanten.LeerForschungAnforderung =>
            BeschreibungText := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugKeines);
            
         when others =>
            AktuelleForschung := 2 * Positive (IDExtern) - 1;
               
            BeschreibungText := GlobaleTexte.Forschungen (AktuelleForschung);
      end case;

      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end Beschreibung;
   
   
   
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

   

   -- Diesen Teil mal aus ForschungAllgemein auslagern. äöü
   -- Hier noch mehr Optionen einbauen, z. B. Informationen über bereits erforschte Technologien
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
      
      InteraktionAuswahl.MöglicheForschungen := (others => False);

      ForschungSchleife:
      for ForschungenSchleifenwert in ForschungenDatentypen.ForschungID loop
         
         case
           ForschungAnforderungErfüllt (RasseExtern       => RasseExtern,
                                         ForschungIDExtern => ForschungenSchleifenwert)
         is
            when True =>
               InteraktionAuswahl.MöglicheForschungen (ForschungenSchleifenwert) := True;
                  
            when False =>
               null;
         end case;
                  
      end loop ForschungSchleife;
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            return 0;
            -- return ForschungAuswahlTerminal;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            return ForschungAuswahlSFML;
      end case;

   end AuswahlForschung;
   
   
   
   function ForschungAuswahlSFML
     return ForschungenDatentypen.ForschungIDMitNullWert
   is begin
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Forschung_Enum;
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausAuswahl;
         
         case
           Eingabe.Tastenwert
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
   
   
   
   function MausAuswahl
      return ForschungenDatentypen.ForschungIDMitNullWert
   is begin
      
      Mausposition := NachLogiktask.Mausposition;
            
      MausZeigerSchleife:
      for ForschungSchleifenwert in InteraktionAuswahl.MöglicheForschungenArray'Range loop
         
         case
           InteraktionAuswahl.MöglicheForschungen (ForschungSchleifenwert)
         is
            when True =>
               if
                 Mausposition.y in InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert).top
                 .. InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert).top + InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert).height
                 and
                   Mausposition.x in InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert).left
                 .. InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert).left + InteraktionAuswahl.PositionenForschung (ForschungSchleifenwert).width
               then
                  return ForschungSchleifenwert;
         
               else
                  null;
               end if;

            when False =>
               null;
         end case;
         
      end loop MausZeigerSchleife;
      
      return ForschungKonstanten.LeerForschungAnforderung;
      
   end MausAuswahl;



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
               
            when RassenDatentypen.KI_Spieler_Enum =>
               FortschrittKI (RasseExtern => RasseSchleifenwert);
         end case;
               
      end loop RasseSchleife;
      
   end ForschungFortschritt;
   
   
   
   -- Die beiden Forschrittprozeduren zusammenführen? Sinnvoll oder könnte es bei Erweiterungen kompliziert werden?
   procedure FortschrittMensch
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      if
        AktuellesForschungsprojekt = ForschungenDatentypen.ForschungIDMitNullWert'First
      then
         null;
         
      elsif
        LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern)
        >= LeseForschungenDatenbank.PreisForschung (RasseExtern => RasseExtern,
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
         
         NachGrafiktask.AktuelleRasse := RasseExtern;
         SchreibeWichtiges.Forschungsprojekt (RasseExtern       => RasseExtern,
                                              ForschungIDExtern => AuswahlForschung (RasseExtern => RasseExtern));
         NachGrafiktask.AktuelleRasse := RassenDatentypen.Keine_Rasse_Enum;
            
      else
         SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      end if;
      
   end FortschrittMensch;
   
   
   
   procedure FortschrittKI
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      if
        AktuellesForschungsprojekt = ForschungenDatentypen.ForschungIDMitNullWert'First
      then
         KIForschung.Forschung (RasseExtern => RasseExtern);
         
      elsif
        LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern)
        >= LeseForschungenDatenbank.PreisForschung (RasseExtern => RasseExtern,
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
                                              ForschungIDExtern => 0);
         KIForschung.Forschung (RasseExtern => RasseExtern);
         StadtWerteFestlegen.StadtUmgebungGrößeFestlegenTechnologie (RasseExtern => RasseExtern);
            
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
            
         if
           LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                         IDExtern                => ForschungIDExtern,
                                                         WelcheAnforderungExtern => AnforderungSchleifenwert)
           = ForschungKonstanten.LeerForschungAnforderung
         then
            null;
            
         elsif
           LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                         IDExtern                => ForschungIDExtern,
                                                         WelcheAnforderungExtern => AnforderungSchleifenwert)
           = ForschungKonstanten.ForschungUnmöglich
         then
            return False;
                  
         elsif
           LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                    WelcheTechnologieExtern => LeseForschungenDatenbank.AnforderungForschung (RasseExtern             => RasseExtern,
                                                                                                             IDExtern                => ForschungIDExtern,
                                                                                                             WelcheAnforderungExtern => AnforderungSchleifenwert))
           = True
         then
            null;
                  
         else
            return False;
         end if;
               
      end loop AnforderungSchleife;
      
      return True;
      
   end ForschungAnforderungErfüllt;

end ForschungAllgemein;
