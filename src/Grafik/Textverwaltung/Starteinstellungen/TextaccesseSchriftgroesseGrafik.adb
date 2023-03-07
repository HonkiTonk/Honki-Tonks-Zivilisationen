with Sf.Graphics.Text;

with TextaccessVariablen;
with TextDatentypen;

with TexteinstellungenGrafik;

package body TextaccesseSchriftgroesseGrafik is

   procedure SchriftgrößeSetzen
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
      
   end SchriftgrößeSetzen;
   
   
   
   procedure Allgemeines
   is begin
      
      Überschrift := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Überschrift_Enum);
      Normal := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum);
      Klein := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Klein_Enum);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ÜberschriftAccess,
                                         size => Überschrift);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.VersionsnummerAccess,
                                         size => Überschrift);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZeilenumbruchAccess,
                                         size => Klein);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.TextAccess,
                                         size => Normal);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.TexthöheAccess,
                                         size => Normal);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.Spielmeldung,
                                         size => Normal);
      
      
      
      IntroSchleife:
      for IntroSchleifenwert in TextaccessVariablen.IntroAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.IntroAccess (IntroSchleifenwert),
                                            size => Normal);
         
      end loop IntroSchleife;
      
      
      
      OutroSchleife:
      for OutroSchleifenwert in TextaccessVariablen.OutroAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.OutroAccess (OutroSchleifenwert),
                                            size => Normal);
         
      end loop OutroSchleife;
      
   end Allgemeines;
   
   
   
   procedure Menüs
   is begin
      
      Normal := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum);
      
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.MenüsAccess (AußenSchleifenwert, InnenSchleifenwert),
                                               size => Normal);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
      
      
      SteuerungSchleife:
      for SteuerungSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SteuerungAccess (SteuerungSchleifenwert),
                                            size => Normal);
         
      end loop SteuerungSchleife;
      
      
      
      SpielstandSchleife:
      for SpielstandSchleifenwert in TextaccessVariablen.SpielstandAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpielstandAccess (SpielstandSchleifenwert),
                                            size => Normal);
         
      end loop SpielstandSchleife;
      
   end Menüs;
      
      
   
   procedure Spezies
   is begin
      
      Überschrift := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Überschrift_Enum);
      Normal := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum);
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in TextaccessVariablen.SpeziesnamenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpeziesnamenAccess (SpeziesSchleifenwert),
                                            size => Normal);
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesSchleifenwert),
                                            size => Normal);
         
         
         
         GebäudetextSchleife:
         for GebäudetextSchleifenwert in TextaccessVariablen.GebäudetextAccessArray'Range (2) loop
         
            case
              GebäudetextSchleifenwert
            is
               when TextaccessVariablen.GebäudetextAccessArray'First (2) =>
                  Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     size => Überschrift);
               
               when others =>
                  Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudetextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     size => Normal);
         
                  Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.GebäudezusatztextAccess (SpeziesSchleifenwert, GebäudetextSchleifenwert),
                                                     size => Normal);
            end case;
         
         end loop GebäudetextSchleife;


      
         EinheitentextSchleife:
         for EinheitentextSchleifenwert in TextaccessVariablen.EinheitentextAccessArray'Range (2) loop
         
            case
              EinheitentextSchleifenwert
            is
            when TextaccessVariablen.EinheitentextAccessArray'First (2) =>
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                  size => Überschrift);
               
            when others =>
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitentextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                  size => Normal);
         
               Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenzusatztextAccess (SpeziesSchleifenwert, EinheitentextSchleifenwert),
                                                  size => Normal);
            end case;
         
         end loop EinheitentextSchleife;
         
         
         
         ForschungstextSchleife:
         for ForschungstextSchleifenwert in TextaccessVariablen.ForschungsmenüAccessArray'Range (2) loop
         
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüAccess (SpeziesSchleifenwert, ForschungstextSchleifenwert),
                                               size => Normal);
               
            Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesSchleifenwert, ForschungstextSchleifenwert),
                                               size => Normal);
         
         end loop ForschungstextSchleife;
         
      end loop SpeziesSchleife;
      
      Sf.Graphics.Text.setCharacterSize (text  => TextaccessVariablen.AktuellesBauprojekt,
                                         size => Normal);
      
      Sf.Graphics.Text.setCharacterSize (text  => TextaccessVariablen.AktuellesForschungsprojekt,
                                         size => Normal);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ForschungsmenüErmöglichtAccess,
                                         size => Normal);
      
   end Spezies;
      
      
   
   procedure ZusatztextKartengröße
   is begin
      
      Normal := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum);
      
      ZusatztextKartengrößeSchleife:
      for ZusatztextSchleifenwert in TextaccessVariablen.ZusatztextKartengrößeAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.ZusatztextKartengrößeAccess (ZusatztextSchleifenwert),
                                            size => Normal);
         
      end loop ZusatztextKartengrößeSchleife;
      
   end ZusatztextKartengröße;
            
      
   
   procedure Sprachauswahl
   is begin
      
      Normal := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SprachauswahlAccess,
                                         size => Normal);
            
   end Sprachauswahl;
   
   
   
   procedure Kartenformauswahl
   is begin
      
      Überschrift := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Überschrift_Enum);
      Normal := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartenformauswahlAccess (TextaccessVariablen.KartenformauswahlAccess'First),
                                         size => Überschrift);
      
      SchriftgrößeSchleife:
      for SchriftgrößeSchleifenwert in TextaccessVariablen.KartenformauswahlAccess'First + 1 .. TextaccessVariablen.KartenformauswahlAccess'Last loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KartenformauswahlAccess (SchriftgrößeSchleifenwert),
                                            size => Normal);
         
      end loop SchriftgrößeSchleife;
      
   end Kartenformauswahl;
   
   
   
   procedure StadtInformationen
   is begin
      
      Normal := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum);
      
      StadtInformationenSchleife:
      for StadtInformationenSchleifenwert in TextaccessVariablen.StadtInformationenAccess'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.StadtInformationenAccess (StadtInformationenSchleifenwert),
                                            size => Normal);
         
      end loop StadtInformationenSchleife;
      
   end StadtInformationen;
   
   
   
   procedure EinheitenInformationen
   is begin
      
      Normal := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum);
      
      EinheitenInformationenSchleife:
      for EinheitenInformationenSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.EinheitenInformationenAccess (EinheitenInformationenSchleifenwert),
                                            size => Normal);
         
      end loop EinheitenInformationenSchleife;
      
   end EinheitenInformationen;
   
   
   
   procedure KarteWichtiges
   is begin
      
      Normal := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum);
      
      KarteWichtigesSchleife:
      for KarteWichtigesSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteWichtigesAccess (KarteWichtigesSchleifenwert),
                                            size => Normal);
         
      end loop KarteWichtigesSchleife;
      
   end KarteWichtiges;
   
   
   
   procedure KarteAllgemeines
   is begin
      
      Normal := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum);
      
      KarteAllgemeinesSchleife:
      for KarteAllgemeinesSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteAllgemeinesAccess (KarteAllgemeinesSchleifenwert),
                                            size => Normal);
         
      end loop KarteAllgemeinesSchleife;
      
   end KarteAllgemeines;
   
   
   
   procedure Karte
   is begin
      
      Überschrift := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Überschrift_Enum);
      
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KarteAccess,
                                         size => Überschrift);
      
   end Karte;
   
   
   
   procedure EinheitStadtAuswahl
   is begin
      
      Normal := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum);
      
      EinheitStadtSchleife:
      for EinheitStadtSchleifenwert in TextaccessVariablen.AnzeigeEinheitStadtAccessArray'Range loop
      
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (EinheitStadtSchleifenwert),
                                            size => Normal);
         
      end loop EinheitStadtSchleife;
      
   end EinheitStadtAuswahl;
   
   
   
   procedure AnzeigeEingabe
   is begin
      
      Normal := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum);
      
      AnzeigeEingabeSchleife:
      for AnzeigeEingabeSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.JaNeinAccess (AnzeigeEingabeSchleifenwert),
                                            size => Normal);
         
      end loop AnzeigeEingabeSchleife;
         
   end AnzeigeEingabe;
   
   
   
   procedure Ladezeiten
   is begin
      
      Normal := TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum);
            
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in TextaccessVariablen.LadezeitenAccess'Range loop
                  
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.LadezeitenAccess (LadezeitenSpielweltSchleifenwert),
                                            size => Normal);
         
      end loop LadezeitenSpielweltSchleife;
      
      
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in TextaccessVariablen.KIZeitenAccess'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.KIZeitenAccess (KIZeitenSchleifenwert),
                                            size => Normal);
         
      end loop KIZeitenSchleife;
               
            
         
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.RundenendeAccess (1),
                                         size => Normal);
      
      
               
      Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.SpeichernLadenAccess (1),
                                         size => Normal);
      
   end Ladezeiten;
   
   
   
   procedure Befehle
   is begin
      
      StadtbefehleSchleife:
      for StadtbefehleSchleifenwert in TextaccessVariablen.StadtbefehleAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextaccessVariablen.StadtbefehleAccess (StadtbefehleSchleifenwert),
                                            size => Normal);
         
      end loop StadtbefehleSchleife;
      
   end Befehle;

end TextaccesseSchriftgroesseGrafik;
