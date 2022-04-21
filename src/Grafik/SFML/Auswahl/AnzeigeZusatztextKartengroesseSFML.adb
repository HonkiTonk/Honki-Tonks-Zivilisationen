pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;

with SystemKonstanten;
with MenueDatentypen;

with GrafikEinstellungenSFML;
with AuswahlMenuesStringsSetzen;
with Karten;
with AllgemeineTextBerechnungenSFML;
with InteraktionAuswahl;

package body AnzeigeZusatztextKartengroesseSFML is

   procedure AnzeigeZusatztextKartengröße
     (AktuelleAuswahlExtern : in Natural)
   is begin
      
      Textbearbeitung (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess (1));
      
      case
        AktuelleAuswahlExtern
      is
         when 0 =>
            null;
            
         when others =>
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextAccess (2));
      end case;
        
   end AnzeigeZusatztextKartengröße;
   
   
   
   procedure Textbearbeitung
     (AktuelleAuswahlExtern : in Natural)
   is begin
      
      case
        SchriftartFestgelegt
      is
         when False =>
            SchriftartFestgelegt := SchriftartFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftfarbeFestgelegt
      is
         when False =>
            SchriftfarbeFestgelegt := SchriftfarbeFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftgrößeFestgelegt
      is
         when False =>
            SchriftgrößeFestgelegt := SchriftgrößeFestlegen;
            
         when True =>
            null;
      end case;
      
      TextFestlegen (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
      PositionFestlegen;
      
   end Textbearbeitung;
   
   
   
   function SchriftartFestlegen
     return Boolean
   is begin
      
      FontSchleife:
      for FontSchleifenwert in TextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextAccess (FontSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop FontSchleife;
            
      return True;
      
   end SchriftartFestlegen;
   
   
   
   function SchriftfarbeFestlegen
     return Boolean
   is begin
      
      FarbeSchleife:
      for FarbeSchleifenwert in TextAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextAccess (FarbeSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop FarbeSchleife;
      
      return True;
      
   end SchriftfarbeFestlegen;
   
   
   
   function SchriftgrößeFestlegen
     return Boolean
   is begin
      
      GrößeSchleife:
      for GrößeSchleifenwert in TextAccessArray'Range loop
         
         Sf.Graphics.Text.setCharacterSize (text => TextAccess (GrößeSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop GrößeSchleife;
      
      return True;
      
   end SchriftgrößeFestlegen;
   
   
   
   procedure TextFestlegen
     (AktuelleAuswahlExtern : in Natural)
   is begin
    
      Sf.Graphics.Text.setUnicodeString (text => TextAccess (1),
                                         str  =>
                                           AuswahlMenuesStringsSetzen.AuswahlMenüZusatztextStringSetzen (WelcheZeileExtern => SystemKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum) - 1,
                                                                                                          WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum) & "    " & "5x"
                                         & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv (ZahlExtern => Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße)) & "x"
                                         & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv (ZahlExtern => Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße)));
      
      case
        AktuelleAuswahlExtern
      is
         when 0 =>
            null;
            
         when others =>
            Sf.Graphics.Text.setUnicodeString (text => TextAccess (2),
                                               str  =>
                                                  AuswahlMenuesStringsSetzen.AuswahlMenüZusatztextStringSetzen (WelcheZeileExtern => SystemKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum),
                                                                                                                 WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum) & "    " & "5x"
                                               & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv
                                                                      (ZahlExtern => Karten.Kartengrößen (KartenDatentypen.Kartengröße_Standard_Enum'Val (AktuelleAuswahlExtern - 1)).YAchsenGröße))
                                               & "x"
                                               & To_Wide_Wide_String (Source => ZahlAlsStringKartenfeldPositiv
                                                                      (ZahlExtern => Karten.Kartengrößen (KartenDatentypen.Kartengröße_Standard_Enum'Val (AktuelleAuswahlExtern - 1)).XAchsenGröße)));
      end case;
      
   end TextFestlegen;
   
   
   
   procedure PositionFestlegen
   is begin
      
      PositionText.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess (1));
      PositionText.y := InteraktionAuswahl.LetzteTextpositionKartengröße + Sf.Graphics.Text.getLocalBounds (text => TextAccess (1)).height;
      
      Sf.Graphics.Text.setPosition (text     => TextAccess (1),
                                    position => PositionText);
      
      PositionText.x := AllgemeineTextBerechnungenSFML.TextMittelPositionErmitteln (TextAccessExtern => TextAccess (2));
      PositionText.y := PositionText.y + 2.00 * Sf.Graphics.Text.getLocalBounds (text => TextAccess (2)).height;
      Sf.Graphics.Text.setPosition (text     => TextAccess (2),
                                    position => PositionText);
      
   end PositionFestlegen;

end AnzeigeZusatztextKartengroesseSFML;
