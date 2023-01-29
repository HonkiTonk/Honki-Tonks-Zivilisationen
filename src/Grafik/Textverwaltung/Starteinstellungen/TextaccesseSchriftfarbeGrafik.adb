with Sf.Graphics.Text;

with TextaccessVariablen;

with TexteinstellungenGrafik;

package body TextaccesseSchriftfarbeGrafik is

   procedure SchriftfarbeSetzen
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
      
   end SchriftfarbeSetzen;
   
   
   
   procedure Allgemeines
   is begin
        
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ÜberschriftAccess,
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeÜberschrift);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.VersionsnummerAccess,
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeSonstigerText);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZeilenumbruchAccess,
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeSonstigerText);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.TextAccess,
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.Spielmeldung,
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
      
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop OutroSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
   is begin
      
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
      
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsAccess (AußenSchleifenwert, InnenSchleifenwert),
                                       color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
      
      
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop SteuerungSchleife;
      
      
      
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop SpielstandSchleife;
      
   end Menüs;
   
   
   
   procedure Spezies
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in TextaccessVariablen.SpeziesnamenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpeziesnamenAccess (SpeziesSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range (2) loop
                     
            case
              GebäudetextSchleifenwert
            is
            when TextaccessVariablen.GebäudetextAccessArray'First (2) =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                          color => TexteinstellungenGrafik.Schriftfarben.FarbeÜberschrift);
               
            when others =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                          color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
               
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudezusatztextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                          color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
            end case;
            
         end loop GebäudetextSchleife;
      
      
            
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range (2) loop
            
            case
              EinheitentextSchleifenwert
            is
            when TextaccessVariablen.EinheitentextAccessArray'First (2) =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                          color => TexteinstellungenGrafik.Schriftfarben.FarbeÜberschrift);
               
            when others =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                          color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
               
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                          color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
            end case;
         
         end loop EinheitentextSchleife;
         
         
         
         ForschungenSchleife:
         for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range (2) loop
         
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                       color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                       color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
         end loop ForschungenSchleife;
         
      end loop SpeziesSchleife;
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
      
   end Spezies;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
   
   
   
   procedure Sprachauswahl
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SprachauswahlAccess,
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
      
   end Sprachauswahl;
   
      
   
   procedure Kartenformauswahl
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccess'First),
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeÜberschrift);
      
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in TextaccessVariablen.KartenformauswahlAccess'First + 1 .. TextaccessVariablen.KartenformauswahlAccess'Last - 1 loop
         
         case
           SchriftfarbeSchleifenwert
         is
            when 10 .. 30 =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (SchriftfarbeSchleifenwert),
                                          color => TexteinstellungenGrafik.Schriftfarben.FarbeMenschText);
               
            when others =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (SchriftfarbeSchleifenwert),
                                          color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         end case;
         
      end loop SchriftfarbeSchleife;
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccess'Last),
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeSonstigerText);
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteAccess,
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
      
   end Karte;
   
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
   is begin
            
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
            
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop LadezeitenSpielweltSchleife;
      
      
            
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop KIZeitenSchleife;
      
      
               
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.RundenendeAccess (1),
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
      
      
               
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpeichernLadenAccess (1),
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
      
   end Ladezeiten;
   
   
   
   procedure Befehle
   is begin
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                    color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseSchriftfarbeGrafik;
