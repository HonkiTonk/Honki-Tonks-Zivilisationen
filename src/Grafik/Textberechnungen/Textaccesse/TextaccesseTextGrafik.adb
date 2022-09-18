pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with TextaccessVariablen;
with Meldungstexte;
with TextnummernKonstanten;
with SonstigesKonstanten;
with Menuetexte;
with BefehleDatentypen;
with Befehlstexte;

with RassenbeschreibungenGrafik;
with ForschungsbeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with GebaeudebeschreibungenGrafik;

package body TextaccesseTextGrafik is

   procedure TextSetzen
   is begin
      
      Allgemeines;
      Menüs;
      Rassen;
      ZusatztextKartengröße;
      Sprachauswahl;
      Kartenformauswahl;
      StadtInformationen;
      EinheitenInformationen;
      KarteWichtiges;
      KarteAllgemeines;
      Karte;
      EinheitStadtAuswahl;
      AnzeigeEingabe;
      Ladezeiten;
      Befehle;
      
   end TextSetzen;
   
   
   
   procedure Allgemeines
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.VersionsnummerAccess,
                                         str  => "Version: " & SonstigesKonstanten.Versionsnummer);
      
   end Allgemeines;
   
   
   
   procedure Menüs
   is begin
            
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungSFMLAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SteuerungSFMLAccess (SteuerungSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Steuerungmenü (SteuerungSchleifenwert)));
         
      end loop SteuerungSchleife;
      
      
      
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Spielstandmenü (SpielstandSchleifenwert)));
         
      end loop SpielstandSchleife;
      
   end Menüs;
      
      
   
   procedure Rassen
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in TextaccessVariablen.RassennamenAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.RassennamenAccess (RasseSchleifenwert),
                                            str  => RassenbeschreibungenGrafik.BeschreibungKurz (RasseExtern => RasseSchleifenwert));
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.RassenbeschreibungAccess (RasseSchleifenwert),
                                            str  => RassenbeschreibungenGrafik.BeschreibungLang (RasseExtern => RasseSchleifenwert));
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range (2) loop
         
            case
              GebäudetextSchleifenwert
            is
               when TextaccessVariablen.GebäudetextAccessArray'First (2) =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudetextAccess (RasseSchleifenwert, GebäudetextSchleifenwert),
                                                     str  => To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugGebäude)));
               
               when others =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudetextAccess (RasseSchleifenwert, GebäudetextSchleifenwert),
                                                     str  => GebaeudebeschreibungenGrafik.BeschreibungKurz (IDExtern    => GebäudetextSchleifenwert,
                                                                                                            RasseExtern => RasseSchleifenwert));
         
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (RasseSchleifenwert, GebäudetextSchleifenwert),
                                                     str  => GebaeudebeschreibungenGrafik.BeschreibungLang (IDExtern    => GebäudetextSchleifenwert,
                                                                                                            RasseExtern => RasseSchleifenwert));
            end case;
            
         end loop GebäudetextSchleife;
      
      
      
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range (2) loop
         
            case
              EinheitentextSchleifenwert
            is
               when TextaccessVariablen.EinheitentextAccessArray'First (2) =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitentextAccess (RasseSchleifenwert, EinheitentextSchleifenwert),
                                                     str  => To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugEinheiten)));
               
               when others =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitentextAccess (RasseSchleifenwert, EinheitentextSchleifenwert),
                                                     str  => EinheitenbeschreibungenGrafik.BeschreibungKurz (IDExtern    => EinheitentextSchleifenwert,
                                                                                                             RasseExtern => RasseSchleifenwert));
         
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenzusatztextAccess (RasseSchleifenwert, EinheitentextSchleifenwert),
                                                     str  => EinheitenbeschreibungenGrafik.BeschreibungLang (IDExtern    => EinheitentextSchleifenwert,
                                                                                                             RasseExtern => RasseSchleifenwert));
            end case;
         
         end loop EinheitentextSchleife;
         
         
         
         ForschungenSchleife:
         for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range (2) loop
         
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüAccess (RasseSchleifenwert, ForschungSchleifenwert),
                                               str  => ForschungsbeschreibungenGrafik.BeschreibungKurz (IDExtern    => ForschungSchleifenwert,
                                                                                                        RasseExtern => RasseSchleifenwert));
         
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseSchleifenwert, ForschungSchleifenwert),
                                               str  => ForschungsbeschreibungenGrafik.BeschreibungLang (IDExtern    => ForschungSchleifenwert,
                                                                                                        RasseExtern => RasseSchleifenwert));
         
         end loop ForschungenSchleife;
      end loop RassenSchleife;
      
   end Rassen;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      null;
      
   end ZusatztextKartengröße;
      
      
   
   procedure Sprachauswahl
   is begin
      
      null;
      
   end Sprachauswahl;
   
   
   
   procedure Kartenformauswahl
   is begin
      
      null;
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      null;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      null;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      null;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      null;
      
   end KarteAllgemeines;
   
   
   
   
   procedure Karte
   is begin
      
      null;
      
   end Karte;
   
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      null;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugJa + AnzeigeEingabeSchleifenwert - TextaccessVariablen.JaNeinAccessArray'First)));
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
      
      null;
      
   end Ladezeiten;
   
   
   
   procedure Befehle
   is begin
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Befehlstexte.Stadtbefehle (BefehleDatentypen.Stadtbefehle_Vorhanden_Enum'Pos (StadtbefehleSchleifenwert))));
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseTextGrafik;
