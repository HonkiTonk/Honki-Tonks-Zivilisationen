pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with TextaccessVariablen;

with GrafikEinstellungenSFML;

package body TextaccesseSchriftartSetzenSFML is

   procedure SchriftartSetzen
   is begin
      
      -- Ein paar der Sachen zusammenfassen? Oder doch lieber nach Dateien/Bereich getrennt lassen? äöü
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
   
   
   
   procedure MenüsEinfach
   is begin
      
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.MenüsEinfachSFMLAccess (AußenSchleifenwert, InnenSchleifenwert),
                                      font => GrafikEinstellungenSFML.SchriftartAccess);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
   end MenüsEinfach;
      
      
   
   procedure ZusatztextRassenmenü
   is begin
      
      ZusatztextRassenmenüSchleife:
      for RasseSchleifenwert in TextaccessVariablen.ZusatztextRassenAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ZusatztextRassenAccess (RasseSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop ZusatztextRassenmenüSchleife;
      
   end ZusatztextRassenmenü;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
      
      
   
   procedure Baumenü
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.BaumenüÜberschriftAccess,
                                font => GrafikEinstellungenSFML.SchriftartAccess);
      
      GebäudetextSchleife:
      for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudetextAccess (GebäudetextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop GebäudetextSchleife;
      
      GebäudezusatztextSchleife:
      for GebäudezusatztextSchleifenwert in TextaccessVariablen.GebäudezusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.GebäudezusatztextAccess (GebäudezusatztextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop GebäudezusatztextSchleife;
      
      
      
      EinheitentextSchleife:
      for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitentextAccess (EinheitentextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop EinheitentextSchleife;
      
      EinheitenzusatztextSchleife:
      for EinheitenzusatztextSchleifenwert in TextaccessVariablen.EinheitenzusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenzusatztextAccess (EinheitenzusatztextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop EinheitenzusatztextSchleife;
      
   end Baumenü;
      
      
   
   procedure Forschungsmenü
   is begin
      
      ForschungenSchleife:
      for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüAccess (ForschungSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop ForschungenSchleife;
      
      ForschungenZusatztextSchleife:
      for ForschungZusatztextSchleifenwert in TextaccessVariablen.ForschungsmenüZusatztextAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (ForschungZusatztextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop ForschungenZusatztextSchleife;
      
   end Forschungsmenü;
      
      
   
   procedure Sprachauswahl
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.SprachauswahlAccess,
                                font => GrafikEinstellungenSFML.SchriftartAccess);
      
   end Sprachauswahl;
   
   
   
   procedure Kartenformauswahl
   is begin
      
      KartenformauswahlSchleife:
      for KartenformauswahlSchleifenwert in TextaccessVariablen.KartenformauswahlAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KartenformauswahlAccess (KartenformauswahlSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop KartenformauswahlSchleife;
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
   is begin
      
      Sf.Graphics.Text.setFont (text => TextaccessVariablen.KarteAccess,
                                font => GrafikEinstellungenSFML.SchriftartAccess);
      
   end Karte;
   
   
   
   procedure Zahleneingabe
   is begin
      
      ZahleneingabeSchleife:
      for ZahleneingabeSchleifenwert in TextaccessVariablen.AnzeigeZahlTexteingabeAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.AnzeigeZahlTexteingabeAccess (ZahleneingabeSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop ZahleneingabeSchleife;
      
   end Zahleneingabe;
   
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
      
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop KIZeitenSchleife;
      
      
      
      RundenendeSchleife:
      for RundenendeSchleifenwert in TextaccessVariablen.RundenendeAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.RundenendeAccess (RundenendeSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop RundenendeSchleife;
      
      
      
      SpeichernLadenSchleife:
      for SpeichernLadenSchleifenwert in TextaccessVariablen.SpeichernLadenAccessArray'Range loop
         
         Sf.Graphics.Text.setFont (text => TextaccessVariablen.SpeichernLadenAccess (SpeichernLadenSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
         
      end loop SpeichernLadenSchleife;
      
   end Ladezeiten;

end TextaccesseSchriftartSetzenSFML;
