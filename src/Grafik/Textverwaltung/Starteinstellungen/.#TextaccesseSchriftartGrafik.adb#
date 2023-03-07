with Sf.Graphics.Text;

with TextaccessVariablen;

with TexteinstellungenGrafik;

package body TextaccesseSchriftartGrafik is

   procedure SchriftartSetzen
   is begin
      
      -- Ein paar der Sachen zusammenfassen? Oder doch lieber nach Dateien/Bereich getrennt lassen? äöü
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
      
   end SchriftartSetzen;
   
   
   
   procedure Allgemeines
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.ÜberschriftAccess,
                                font => TexteinstellungenGrafik.SchriftartLesen);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.VersionsnummerAccess,
                                font => TexteinstellungenGrafik.SchriftartLesen);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.ZeilenumbruchAccess,
                                font => TexteinstellungenGrafik.SchriftartLesen);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.TextAccess,
                                font => TexteinstellungenGrafik.SchriftartLesen);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.TexthöheAccess,
                                font => TexteinstellungenGrafik.SchriftartLesen);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.Spielmeldung,
                                font => TexteinstellungenGrafik.SchriftartLesen);
      
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
      end loop OutroSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
   is begin
      
      MenüsAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.MenüsAccess (AußenSchleifenwert, InnenSchleifenwert),
                                      font => TexteinstellungenGrafik.SchriftartLesen);
            
         end loop MenüsInnenSchleife;
      end loop MenüsAußenSchleife;
      
      
      
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
      end loop SteuerungSchleife;
      
      
      
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
      end loop SpielstandSchleife;
      
   end Menüs;
      
      
   
   procedure Spezies
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in TextaccessVariablen.SpeziesnamenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SpeziesnamenAccess (SpeziesSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccess'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                      font => TexteinstellungenGrafik.SchriftartLesen);
         
            case
              GebäudetextSchleifenwert
            is
               when TextaccessVariablen.GebäudetextAccess'First (2) =>
                  null;
               
               when others =>
                  Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudezusatztextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                            font => TexteinstellungenGrafik.SchriftartLesen);
            end case;
            
         end loop GebäudetextSchleife;
      
      
      
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccess'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                      font => TexteinstellungenGrafik.SchriftartLesen);
         
            case
              EinheitentextSchleifenwert
            is
               when TextaccessVariablen.EinheitentextAccess'First (2) =>
                  null;
               
               when others =>
                  Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                            font => TexteinstellungenGrafik.SchriftartLesen);
            end case;
            
         end loop EinheitentextSchleife;
         
         
         
         ForschungenSchleife:
         for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccess'Range (2) loop
         
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                      font => TexteinstellungenGrafik.SchriftartLesen);
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                      font => TexteinstellungenGrafik.SchriftartLesen);
         
         end loop ForschungenSchleife;
         
      end loop SpeziesSchleife;
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.AktuellesBauprojekt,
                                font => TexteinstellungenGrafik.SchriftartLesen);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.AktuellesForschungsprojekt,
                                font => TexteinstellungenGrafik.SchriftartLesen);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                font => TexteinstellungenGrafik.SchriftartLesen);
      
   end Spezies;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
   
      
   
   procedure Sprachauswahl
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.SprachauswahlAccess,
                                font => TexteinstellungenGrafik.SchriftartLesen);
      
   end Sprachauswahl;
   
   
   
   procedure Kartenformauswahl
   is begin
      
      KartenformauswahlSchleife:
      for KartenformauswahlSchleifenwert in TextaccessVariablen.KartenformauswahlAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KartenformauswahlAccess (KartenformauswahlSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
            
      end loop KartenformauswahlSchleife;
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
            
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
            
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
            
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
            
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteAccess,
                                font => TexteinstellungenGrafik.SchriftartLesen);
      
   end Karte;
      
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
      
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
      end loop KIZeitenSchleife;
      
      
      
      RundenendeSchleife:
      for RundenendeSchleifenwert in TextaccessVariablen.RundenendeAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.RundenendeAccess (RundenendeSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
      end loop RundenendeSchleife;
      
      
      
      SpeichernLadenSchleife:
      for SpeichernLadenSchleifenwert in TextaccessVariablen.SpeichernLadenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SpeichernLadenAccess (SpeichernLadenSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
      end loop SpeichernLadenSchleife;
      
   end Ladezeiten;
   
   
   
   procedure Befehle
   is begin
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartLesen);
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseSchriftartGrafik;
