with Sf.Graphics.Text;

with TextaccessVariablen;

with TexteinstellungenGrafik;

package body TextaccesseSchriftartGrafik is

   procedure SchriftartSetzen
   is begin
      
      -- Ein paar der Sachen zusammenfassen? Oder doch lieber nach Dateien/Bereich getrennt lassen? äöü
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
      
   end SchriftartSetzen;
   
   
   
   procedure Allgemeines
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.ÜberschriftAccess,
                                font => TexteinstellungenGrafik.SchriftartAccess);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.VersionsnummerAccess,
                                font => TexteinstellungenGrafik.SchriftartAccess);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.ZeilenumbruchAccess,
                                font => TexteinstellungenGrafik.SchriftartAccess);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.TextAccess,
                                font => TexteinstellungenGrafik.SchriftartAccess);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.Spielmeldung,
                                font => TexteinstellungenGrafik.SchriftartAccess);
      
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
      end loop OutroSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
   is begin
      
      MenüsAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.MenüsAccess (AußenSchleifenwert, InnenSchleifenwert),
                                      font => TexteinstellungenGrafik.SchriftartAccess);
            
         end loop MenüsInnenSchleife;
      end loop MenüsAußenSchleife;
      
      
      
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
      end loop SteuerungSchleife;
      
      
      
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
      end loop SpielstandSchleife;
      
   end Menüs;
      
      
   
   procedure Rassen
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in TextaccessVariablen.RassennamenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.RassennamenAccess (RasseSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.RassenbeschreibungAccess (RasseSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccess'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudetextAccess (RasseSchleifenwert, GebäudetextSchleifenwert),
                                      font => TexteinstellungenGrafik.SchriftartAccess);
         
            case
              GebäudetextSchleifenwert
            is
               when TextaccessVariablen.GebäudetextAccess'First (2) =>
                  null;
               
               when others =>
                  Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudezusatztextAccess (RasseSchleifenwert, GebäudetextSchleifenwert),
                                            font => TexteinstellungenGrafik.SchriftartAccess);
            end case;
            
         end loop GebäudetextSchleife;
      
      
      
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccess'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitentextAccess (RasseSchleifenwert, EinheitentextSchleifenwert),
                                      font => TexteinstellungenGrafik.SchriftartAccess);
         
            case
              EinheitentextSchleifenwert
            is
               when TextaccessVariablen.EinheitentextAccess'First (2) =>
                  null;
               
               when others =>
                  Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenzusatztextAccess (RasseSchleifenwert, EinheitentextSchleifenwert),
                                            font => TexteinstellungenGrafik.SchriftartAccess);
            end case;
            
         end loop EinheitentextSchleife;
         
         
         
         ForschungenSchleife:
         for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccess'Range (2) loop
         
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüAccess (RasseSchleifenwert, ForschungSchleifenwert),
                                      font => TexteinstellungenGrafik.SchriftartAccess);
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseSchleifenwert, ForschungSchleifenwert),
                                      font => TexteinstellungenGrafik.SchriftartAccess);
         
         end loop ForschungenSchleife;
         
      end loop RassenSchleife;
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                font => TexteinstellungenGrafik.SchriftartAccess);
      
   end Rassen;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
   
      
   
   procedure Sprachauswahl
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.SprachauswahlAccess,
                                font => TexteinstellungenGrafik.SchriftartAccess);
      
   end Sprachauswahl;
   
   
   
   procedure Kartenformauswahl
   is begin
      
      KartenformauswahlSchleife:
      for KartenformauswahlSchleifenwert in TextaccessVariablen.KartenformauswahlAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KartenformauswahlAccess (KartenformauswahlSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
            
      end loop KartenformauswahlSchleife;
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
            
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
            
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
            
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
            
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteAccess,
                                font => TexteinstellungenGrafik.SchriftartAccess);
      
   end Karte;
      
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
      
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
      end loop KIZeitenSchleife;
      
      
      
      RundenendeSchleife:
      for RundenendeSchleifenwert in TextaccessVariablen.RundenendeAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.RundenendeAccess (RundenendeSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
      end loop RundenendeSchleife;
      
      
      
      SpeichernLadenSchleife:
      for SpeichernLadenSchleifenwert in TextaccessVariablen.SpeichernLadenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SpeichernLadenAccess (SpeichernLadenSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
      end loop SpeichernLadenSchleife;
      
   end Ladezeiten;
   
   
   
   procedure Befehle
   is begin
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                   font => TexteinstellungenGrafik.SchriftartAccess);
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseSchriftartGrafik;
