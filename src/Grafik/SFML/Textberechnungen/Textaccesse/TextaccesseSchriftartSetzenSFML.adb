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
      MenüsEinfach;
      ZusatztextRassenmenü;
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
      Zahleneingabe;
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
      
   end Allgemeines;
   
   
   
   procedure MenüsEinfach
   is begin
      
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.MenüsEinfachSFMLAccess (AußenSchleifenwert, InnenSchleifenwert),
                                      font => TexteinstellungenSFML.SchriftartAccess);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
   end MenüsEinfach;
      
      
   
   procedure ZusatztextRassenmenü
   is begin
      
      ZusatztextRassenmenüSchleife:
      for RasseSchleifenwert in TextaccessVariablen.ZusatztextRassenAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ZusatztextRassenAccess (RasseSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop ZusatztextRassenmenüSchleife;
      
   end ZusatztextRassenmenü;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccessArray'Range loop
         
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
      for KartenformauswahlSchleifenwert in TextaccessVariablen.KartenformauswahlAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KartenformauswahlAccess (KartenformauswahlSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
            
      end loop KartenformauswahlSchleife;
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
            
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
            
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
            
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
            
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteAccess,
                                font => TexteinstellungenSFML.SchriftartAccess);
      
   end Karte;
   
   
   
   procedure Zahleneingabe
   is begin
      
      ZahleneingabeSchleife:
      for ZahleneingabeSchleifenwert in TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (ZahleneingabeSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop ZahleneingabeSchleife;
      
   end Zahleneingabe;
   
   
   
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
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop KIZeitenSchleife;
      
      
      
      RundenendeSchleife:
      for RundenendeSchleifenwert in TextaccessVariablen.RundenendeAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.RundenendeAccess (RundenendeSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop RundenendeSchleife;
      
      
      
      SpeichernLadenSchleife:
      for SpeichernLadenSchleifenwert in TextaccessVariablen.SpeichernLadenAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SpeichernLadenAccess (SpeichernLadenSchleifenwert),
                                   font => TexteinstellungenSFML.SchriftartAccess);
         
      end loop SpeichernLadenSchleife;
      
   end Ladezeiten;

end TextaccesseSchriftartSetzenSFML;
