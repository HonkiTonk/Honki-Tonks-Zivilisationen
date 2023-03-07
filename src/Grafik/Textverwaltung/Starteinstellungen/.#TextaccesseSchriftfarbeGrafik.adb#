with Sf.Graphics.Text;

with TextaccessVariablen;
with TextDatentypen;

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
      
      Überschriftfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Überschrift_Enum);
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      SonstigeFarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Sonstiges_Enum);
        
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ÜberschriftAccess,
                                 color => Überschriftfarbe);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.VersionsnummerAccess,
                                 color => SonstigeFarbe);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZeilenumbruchAccess,
                                 color => SonstigeFarbe);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.TextAccess,
                                 color => Standardfarbe);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.TexthöheAccess,
                                 color => Standardfarbe);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.Spielmeldung,
                                 color => Standardfarbe);
      
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                    color => Standardfarbe);
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                    color => Standardfarbe);
         
      end loop OutroSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
   is begin
      
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
      
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.MenüsAccess (AußenSchleifenwert, InnenSchleifenwert),
                                       color => Standardfarbe);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
      
      
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                    color => Standardfarbe);
         
      end loop SteuerungSchleife;
      
      
      
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                    color => Standardfarbe);
         
      end loop SpielstandSchleife;
      
   end Menüs;
   
   
   
   procedure Spezies
   is begin
      
      Überschriftfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Überschrift_Enum);
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in TextaccessVariablen.SpeziesnamenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpeziesnamenAccess (SpeziesSchleifenwert),
                                    color => Standardfarbe);
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesSchleifenwert),
                                    color => Standardfarbe);
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range (2) loop
                     
            case
              GebäudetextSchleifenwert
            is
            when TextaccessVariablen.GebäudetextAccessArray'First (2) =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                          color => Überschriftfarbe);
               
            when others =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                          color => Standardfarbe);
               
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.GebäudezusatztextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                          color => Standardfarbe);
            end case;
            
         end loop GebäudetextSchleife;
      
      
            
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range (2) loop
            
            case
              EinheitentextSchleifenwert
            is
            when TextaccessVariablen.EinheitentextAccessArray'First (2) =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                          color => Überschriftfarbe);
               
            when others =>
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                          color => Standardfarbe);
               
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                          color => Standardfarbe);
            end case;
         
         end loop EinheitentextSchleife;
         
         
         
         ForschungenSchleife:
         for ForschungSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range (2) loop
         
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                       color => Standardfarbe);
         
            Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesSchleifenwert, ForschungSchleifenwert),
                                       color => Standardfarbe);
         
         end loop ForschungenSchleife;
         
      end loop SpeziesSchleife;
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AktuellesBauprojekt,
                                 color => Standardfarbe);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AktuellesForschungsprojekt,
                                 color => Standardfarbe);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                 color => Standardfarbe);
      
   end Spezies;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                    color => Standardfarbe);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
   
   
   
   procedure Sprachauswahl
   is begin
      
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SprachauswahlAccess,
                                 color => Standardfarbe);
      
   end Sprachauswahl;
   
      
   
   procedure Kartenformauswahl
   is begin
      
      Überschriftfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Überschrift_Enum);
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccess'First),
                                 color => Überschriftfarbe);
      
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in TextaccessVariablen.KartenformauswahlAccess'First + 1 .. TextaccessVariablen.KartenformauswahlAccess'Last loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KartenformauswahlAccess (SchriftfarbeSchleifenwert),
                                    color => Standardfarbe);
         
      end loop SchriftfarbeSchleife;
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                    color => Standardfarbe);
         
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                    color => Standardfarbe);
         
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                    color => Standardfarbe);
         
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                    color => Standardfarbe);
         
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
   is begin
      
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KarteAccess,
                                 color => Standardfarbe);
      
   end Karte;
   
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                    color => Standardfarbe);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
   is begin
      
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
            
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                    color => Standardfarbe);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
      
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
            
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                    color => Standardfarbe);
         
      end loop LadezeitenSpielweltSchleife;
      
      
            
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                    color => Standardfarbe);
         
      end loop KIZeitenSchleife;
      
      
               
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.RundenendeAccess (1),
                                 color => Standardfarbe);
      
      
               
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.SpeichernLadenAccess (1),
                                 color => Standardfarbe);
      
   end Ladezeiten;
   
   
   
   procedure Befehle
   is begin
      
      Standardfarbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                    color => Standardfarbe);
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseSchriftfarbeGrafik;
