with TextaccessVariablen;

package body TextaccesseSchriftstilGrafik is

   procedure SchriftstilSetzen
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      Allgemeines (StilExtern => StilExtern);
      Menüs (StilExtern => StilExtern);
      Spezies (StilExtern => StilExtern);
      ZusatztextKartengröße (StilExtern => StilExtern);
      Sprachauswahl (StilExtern => StilExtern);
      Kartenformauswahl (StilExtern => StilExtern);
      StadtInformationen (StilExtern => StilExtern);
      EinheitenInformationen (StilExtern => StilExtern);
      KarteWichtiges (StilExtern => StilExtern);
      KarteAllgemeines (StilExtern => StilExtern);
      Karte (StilExtern => StilExtern);
      EinheitStadtAuswahl (StilExtern => StilExtern);
      AnzeigeEingabe (StilExtern => StilExtern);
      Ladezeiten (StilExtern => StilExtern);
      Befehle (StilExtern => StilExtern);
      
   end SchriftstilSetzen;
   
   
   
   procedure Allgemeines
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.ÜberschriftAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.VersionsnummerAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.ZeilenumbruchAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.TexthöheAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.Spielmeldung,
                                 style => StilExtern);
                  
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.BildrateAccess,
                                 style => StilExtern);
      
      -- Später das Zeug überall sortieren. äöü
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.DiplomatieAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.EinheitenseitenleisteAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.EingabenanzeigeAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.EinheitenbauinformationenAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.GebäudebauinformationenAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.StadtkarteAccess,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.StadtumgebungAccess,
                                 style => StilExtern);
      -- Später das Zeug überall sortieren. äöü
      
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                    style => StilExtern);
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                    style => StilExtern);
         
      end loop OutroSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      MenüsAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setStyle (text => TextaccessVariablen.MenüsAccess (AußenSchleifenwert, InnenSchleifenwert),
                                       style => StilExtern);
            
         end loop MenüsInnenSchleife;
      end loop MenüsAußenSchleife;
      
      
      
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                    style => StilExtern);
         
      end loop SteuerungSchleife;
      
      
      
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                    style => StilExtern);
         
      end loop SpielstandSchleife;
      
      
      
      BauaufteilungSchleife:
      for BauaufteilungSchleifenwert in TextaccessVariablen.GebäudeaufteilungAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.GebäudeaufteilungAccess (BauaufteilungSchleifenwert),
                                    style => StilExtern);
         
      end loop BauaufteilungSchleife;
      
   end Menüs;
      
      
   
   procedure Spezies
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in TextaccessVariablen.SpeziesnamenAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.SpeziesnamenAccess (SpeziesSchleifenwert),
                                    style => StilExtern);
         
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesSchleifenwert),
                                    style => StilExtern);
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccess'Range (2) loop
            
            Sf.Graphics.Text.setStyle (text => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                       style => StilExtern);
         
            case
              GebäudetextSchleifenwert
            is
               when TextaccessVariablen.GebäudetextAccess'First (2) =>
                  null;
               
               when others =>
                  Sf.Graphics.Text.setStyle (text => TextaccessVariablen.GebäudezusatztextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                             style => StilExtern);
            end case;
            
         end loop GebäudetextSchleife;
      
      
      
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccess'Range (2) loop
            
            Sf.Graphics.Text.setStyle (text => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                       style => StilExtern);
         
            case
              EinheitentextSchleifenwert
            is
               when TextaccessVariablen.EinheitentextAccess'First (2) =>
                  null;
               
               when others =>
                  Sf.Graphics.Text.setStyle (text => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                             style => StilExtern);
            end case;
            
         end loop EinheitentextSchleife;
         
         
         
         ForschungenSchleife:
         for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccess'Range (2) loop
         
            Sf.Graphics.Text.setStyle (text => TextaccessVariablen.ForschungsmenüAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                       style => StilExtern);
            
            Sf.Graphics.Text.setStyle (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                       style => StilExtern);
         
         end loop ForschungenSchleife;
         
      end loop SpeziesSchleife;
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.AktuellesBauprojekt,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.AktuellesForschungsprojekt,
                                 style => StilExtern);
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                 style => StilExtern);
      
   end Spezies;
      
      
   
   procedure ZusatztextKartengröße
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                    style => StilExtern);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
   
      
   
   procedure Sprachauswahl
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.SprachauswahlAccess,
                                 style => StilExtern);
      
   end Sprachauswahl;
   
   
   
   procedure Kartenformauswahl
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      KartenformauswahlSchleife:
      for KartenformauswahlSchleifenwert in TextaccessVariablen.KartenformauswahlAccess'Range loop
            
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.KartenformauswahlAccess (KartenformauswahlSchleifenwert),
                                    style => StilExtern);
            
      end loop KartenformauswahlSchleife;
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
            
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                    style => StilExtern);
            
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
            
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                    style => StilExtern);
            
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
            
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                    style => StilExtern);
            
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
            
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                    style => StilExtern);
            
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      Sf.Graphics.Text.setStyle (text => TextaccessVariablen.KarteAccess,
                                 style => StilExtern);
      
   end Karte;
      
   
   
   procedure EinheitStadtAuswahl
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                    style => StilExtern);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                    style => StilExtern);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                    style => StilExtern);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                    style => StilExtern);
         
      end loop KIZeitenSchleife;
      
      
      
      RundenendeSchleife:
      for RundenendeSchleifenwert in TextaccessVariablen.RundenendeAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.RundenendeAccess (RundenendeSchleifenwert),
                                    style => StilExtern);
         
      end loop RundenendeSchleife;
      
      
      
      SpeichernLadenSchleife:
      for SpeichernLadenSchleifenwert in TextaccessVariablen.SpeichernLadenAccess'Range loop
         
         Sf.Graphics.Text.setStyle (text => TextaccessVariablen.SpeichernLadenAccess (SpeichernLadenSchleifenwert),
                                    style => StilExtern);
         
      end loop SpeichernLadenSchleife;
      
   end Ladezeiten;
   
   
   
   procedure Befehle
     (StilExtern : in Sf.Graphics.Text.sfTextStyle)
   is begin
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setStyle (text  => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                    style => StilExtern);
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseSchriftstilGrafik;
