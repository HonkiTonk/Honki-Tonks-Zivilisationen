pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with TextaccessVariablen;

with TexteinstellungenSFML;

package body TextaccesseSchriftartSetzenSFML is

   procedure SchriftartSetzen
   is begin
      
      -- Ein paar der Sachen zusammenfassen? Oder doch lieber nach Dateien/Bereich getrennt lassen? äöü
      Allgemeines;
      Menüs;
      Rassen;
      ZusatztextKartengröße;
      Baumenü;
      Forschungsmenü;
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
      
   end SchriftartSetzen;
   
   
   
   procedure Allgemeines
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.ÜberschriftAccess,
                                font => TexteinstellungenSFML.SchriftartAccess);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.VersionsnummerAccess,
                                font => TexteinstellungenSFML.SchriftartAccess);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.ZeilenumbruchAccess,
                                font => TexteinstellungenSFML.SchriftartAccess);
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.TextAccess,
                                font => TexteinstellungenSFML.SchriftartAccess);
      
   end Allgemeines;
   
   
   
   procedure Menüs
   is begin
      
      MenüsAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.MenüsSFMLAccess (AußenSchleifenwert, InnenSchleifenwert),
                                      font => TexteinstellungenSFML.SchriftartAccess);
            
         end loop MenüsInnenSchleife;
      end loop MenüsAußenSchleife;
      
      
      
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungSFMLAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SteuerungSFMLAccess (SteuerungSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop SteuerungSchleife;
      
   end Menüs;
      
      
   
   procedure Rassen
   is begin
      
      ZusatztextRassenmenüSchleife:
      for RasseSchleifenwert in TextaccessVariablen.RassenbeschreibungAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.RassennamenAccess (RasseSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.RassenbeschreibungAccess (RasseSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop ZusatztextRassenmenüSchleife;
      
   end Rassen;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
      
      
   
   procedure Baumenü
   is begin
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudetextAccess (GebäudetextSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
         case
           GebäudetextSchleifenwert
         is
            when TextaccessVariablen.GebäudetextAccessArray'First =>
               null;
               
            when others =>
               Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudezusatztextAccess (GebäudetextSchleifenwert),
                                         font => TexteinstellungenSFML.SchriftartAccess);
         end case;
            
      end loop GebäudetextSchleife;
      
      
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitentextAccess (EinheitentextSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
         case
           EinheitentextSchleifenwert
         is
            when TextaccessVariablen.EinheitentextAccessArray'First =>
               null;
               
            when others =>
               Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenzusatztextAccess (EinheitentextSchleifenwert),
                                         font => TexteinstellungenSFML.SchriftartAccess);
         end case;
            
      end loop EinheitentextSchleife;
      
   end Baumenü;
      
      
   
   procedure Forschungsmenü
   is begin
      
      ForschungenSchleife:
      for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (ForschungSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop ForschungenSchleife;
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                font => TexteinstellungenSFML.SchriftartAccess);
      
   end Forschungsmenü;
   
      
   
   procedure Sprachauswahl
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.SprachauswahlAccess,
                                font => TexteinstellungenSFML.SchriftartAccess);
      
   end Sprachauswahl;
   
   
   
   procedure Kartenformauswahl
   is begin
      
      KartenformauswahlSchleife:
      for KartenformauswahlSchleifenwert in TextaccessVariablen.KartenformauswahlAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KartenformauswahlAccess (KartenformauswahlSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
            
      end loop KartenformauswahlSchleife;
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
            
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
            
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
            
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
            
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteAccess,
                                font => TexteinstellungenSFML.SchriftartAccess);
      
   end Karte;
      
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
      
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop KIZeitenSchleife;
      
      
      
      RundenendeSchleife:
      for RundenendeSchleifenwert in TextaccessVariablen.RundenendeAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.RundenendeAccess (RundenendeSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop RundenendeSchleife;
      
      
      
      SpeichernLadenSchleife:
      for SpeichernLadenSchleifenwert in TextaccessVariablen.SpeichernLadenAccess'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SpeichernLadenAccess (SpeichernLadenSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop SpeichernLadenSchleife;
      
   end Ladezeiten;

end TextaccesseSchriftartSetzenSFML;
