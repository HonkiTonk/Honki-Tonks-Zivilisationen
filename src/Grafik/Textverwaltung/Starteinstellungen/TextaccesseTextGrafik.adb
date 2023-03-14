with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with TextaccessVariablen;
with Meldungstexte;
with TextnummernKonstanten;
with SonstigesKonstanten;
with Menuetexte;
with BefehleDatentypen;
with Befehlstexte;
with Spieltexte;

with SpeziesbeschreibungenGrafik;
with ForschungsbeschreibungenGrafik;
with EinheitenbeschreibungenGrafik;
with GebaeudebeschreibungenGrafik;

package body TextaccesseTextGrafik is

   procedure TextSetzen
   is begin
      
      Allgemeines;
      Menüs;
      Spezies;
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
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TexthöheAccess,
                                         str  => "abcdefghijklmnopqrstuvwxyzäöüß   ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ   0123456789   ?!§$%&/()=:;.,<>|'*+#");
      
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Spieltexte.Intro (IntroSchleifenwert)));
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Spieltexte.Outro (OutroSchleifenwert)));
         
      end loop OutroSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
   is begin
            
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Steuerungmenü (SteuerungSchleifenwert)));
         
      end loop SteuerungSchleife;
      
      
      
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                            str  => To_Wide_Wide_String (Source => Menuetexte.Spielstandmenü (SpielstandSchleifenwert)));
         
      end loop SpielstandSchleife;
      
   end Menüs;
      
      
   
   procedure Spezies
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in TextaccessVariablen.SpeziesnamenAccess'Range loop
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpeziesnamenAccess (SpeziesSchleifenwert),
                                            str  => SpeziesbeschreibungenGrafik.Kurzbeschreibung (SpeziesExtern => SpeziesSchleifenwert));
         
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesSchleifenwert),
                                            str  => SpeziesbeschreibungenGrafik.Langbeschreibung (SpeziesExtern => SpeziesSchleifenwert));
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range (2) loop
         
            case
              GebäudetextSchleifenwert
            is
               when TextaccessVariablen.GebäudetextAccessArray'First (2) =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     str  => To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugGebäude)));
               
               when others =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     str  => GebaeudebeschreibungenGrafik.Kurzbeschreibung (IDExtern      => GebäudetextSchleifenwert,
                                                                                                            SpeziesExtern => SpeziesSchleifenwert));
         
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.GebäudezusatztextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     str  => GebaeudebeschreibungenGrafik.Langbeschreibung (IDExtern      => GebäudetextSchleifenwert,
                                                                                                            SpeziesExtern => SpeziesSchleifenwert));
            end case;
            
         end loop GebäudetextSchleife;
      
      
      
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range (2) loop
         
            case
              EinheitentextSchleifenwert
            is
               when TextaccessVariablen.EinheitentextAccessArray'First (2) =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                     str  => To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugEinheiten)));
               
               when others =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                     str  => EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => EinheitentextSchleifenwert,
                                                                                                             SpeziesExtern => SpeziesSchleifenwert));
         
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                     str  => EinheitenbeschreibungenGrafik.Langbeschreibung (IDExtern      => EinheitentextSchleifenwert,
                                                                                                             SpeziesExtern => SpeziesSchleifenwert));
            end case;
         
         end loop EinheitentextSchleife;
         
         
         
         ForschungenSchleife:
         for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range (2) loop
         
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                               str  => ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => ForschungSchleifenwert,
                                                                                                        SpeziesExtern => SpeziesSchleifenwert));
         
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                               str  => ForschungsbeschreibungenGrafik.Langbeschreibung (IDExtern      => ForschungSchleifenwert,
                                                                                                        SpeziesExtern => SpeziesSchleifenwert));
         
         end loop ForschungenSchleife;
      end loop SpeziesSchleife;
      
   end Spezies;
      
      
   
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
                                            str  => To_Wide_Wide_String (Source => Befehlstexte.Stadtbefehle (BefehleDatentypen.Stadtbefehle_Auswählen_Enum'Pos (StadtbefehleSchleifenwert) - 1)));
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseTextGrafik;
