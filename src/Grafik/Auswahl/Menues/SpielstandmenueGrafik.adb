with Ada.Directories;
with Ada.Calendar.Formatting;
with Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with Views;
with GrafikDatentypen;
with TextaccessVariablen;
with InteraktionAuswahl;
with MenueDatentypen;
with TextKonstanten;
with GrafikKonstanten;
with ViewKonstanten;
with TextDatentypen;
with SpielstandVariablen;

with LeseGrafiktask;

with HintergrundGrafik;
with ViewsEinstellenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with TextfarbeGrafik;
with TextaccessverwaltungssystemEinfachGrafik;
with TextskalierungGrafik;
with TexteinstellungenGrafik;
with UmwandlungenVerzeichnisse;
with AllgemeineViewsGrafik;
with UmwandlungssystemHTB3;

package body SpielstandmenueGrafik is

   procedure Spielstandmenü
     (AuswahlExtern : in SystemRecords.DoppelauswahlRecord;
      SpielstandartExtern : in SystemDatentypen.Spielstand_Enum;
      SpeichernLadenExtern : in Boolean)
   is begin
      
      case
        SpeichernLadenExtern
      is
         when True =>
            AllgemeineViewsGrafik.ÜberschriftErmitteln (WelchesMenüExtern => MenueDatentypen.Spielstand_Menü_Enum,
                                                         ZeileExtern       => Speichermenü);
            
         when False =>
            AllgemeineViewsGrafik.ÜberschriftErmitteln (WelchesMenüExtern => MenueDatentypen.Spielstand_Menü_Enum,
                                                         ZeileExtern       => Lademenü);
      end case;
      
      ViewflächeAufteilung := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeAufteilung,
                                                                                  VerhältnisExtern => (GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandKategorie).width,
                                                                                                        GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandKategorie).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SpielstandviewAccesse (ViewKonstanten.SpielstandKategorie),
                                            GrößeExtern          => ViewflächeAufteilung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandKategorie));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                    AbmessungenExtern => ViewflächeAufteilung);
                  
      ViewflächeAufteilung := Spielstandaufteilung (AuswahlExtern       => AuswahlExtern.Zweitauswahl,
                                                     SpielstandartExtern => SpielstandartExtern);
            
      
      
      ViewflächeBelegung := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => ViewflächeBelegung,
                                                                                                 VerhältnisExtern => (GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandAuswahl).width,
                                                                                                                       GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandAuswahl).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SpielstandviewAccesse (ViewKonstanten.SpielstandAuswahl),
                                            GrößeExtern          => ViewflächeBelegung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Spielstandbereich (ViewKonstanten.SpielstandAuswahl));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                    AbmessungenExtern => ViewflächeBelegung);
      
      ViewflächeBelegung := Textanzeige (ViewflächeExtern     => ViewflächeBelegung,
                                          AuswahlExtern        => AuswahlExtern.Erstauswahl,
                                          SpielstandartExtern  => SpielstandartExtern,
                                          SpeichernLadenExtern => SpeichernLadenExtern);
      
   end Spielstandmenü;
   
   
   
   function Spielstandaufteilung
     (AuswahlExtern : in Integer;
      SpielstandartExtern : in SystemDatentypen.Spielstand_Enum)
      return Sf.System.Vector2.sfVector2f
   is
      use type SystemDatentypen.Spielstand_Enum;
   begin
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.Spaltenabstand;
      
      AufteilungSchleife:
      for AufteilungSchleifenwert in InteraktionAuswahl.PositionenSpielstandaufteilung'Range loop
         
         if
           AuswahlExtern = -AufteilungSchleifenwert
         then
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Ausgewählt_Enum);
         
         elsif
           SpielstandartExtern = SystemDatentypen.Manueller_Spielstand_Enum
           and
             AufteilungSchleifenwert = -AuswahlKonstanten.ManuellerSpielstand
         then
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Aktiver_Menübereich_Enum);
            
         elsif
           SpielstandartExtern = SystemDatentypen.Automatischer_Spielstand_Enum
           and
             AufteilungSchleifenwert = -AuswahlKonstanten.AutomatischerSpielstand
         then
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Aktiver_Menübereich_Enum);
           
         else
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
         end if;
         
         TextaccessverwaltungssystemEinfachGrafik.PositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.SpielstandAccess (AufteilungSchleifenwert + MenueKonstanten.StandardArrayanpassung),
                                                                         PositionExtern   => Textposition,
                                                                         FarbeExtern      => Farbe);
         
         InteraktionAuswahl.PositionenSpielstandaufteilung (AufteilungSchleifenwert)
           := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SpielstandAccess (AufteilungSchleifenwert + MenueKonstanten.StandardArrayanpassung));
      
         Textposition.x := Textposition.x + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.SpielstandAccess (AufteilungSchleifenwert + MenueKonstanten.StandardArrayanpassung)).width
           + GrafikKonstanten.Verdoppelung * TextberechnungenBreiteGrafik.Spaltenabstand;
         
      end loop AufteilungSchleife;
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
      return (Textposition.x, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
   end Spielstandaufteilung;
   
   
   
   function Textanzeige
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AuswahlExtern : in Integer;
      SpielstandartExtern : in SystemDatentypen.Spielstand_Enum;
      SpeichernLadenExtern : in Boolean)
      return Sf.System.Vector2.sfVector2f
   is
      use Ada.Strings.Wide_Wide_Unbounded;
   begin
      
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      NeueTextbreite := GrafikKonstanten.Nullwert;
      
      MehrereSeiten := LeseGrafiktask.Seitenauswahl;
      Spielstand := SpielstandVariablen.GanzeSpielstandliste;
      
      TextSchleife:
      for TextSchleifenwert in MenueKonstanten.SpielstandAnfang .. MenueKonstanten.EndeAbzugGrafik (MenueDatentypen.Spielstand_Menü_Enum) loop
         
         if
           SpeichernLadenExtern = False
           and
             TextSchleifenwert = NeuerSpielstand
         then
            null;
            
         elsif
           TextSchleifenwert = MehrAnzeigen
           and
             MehrereSeiten = False
         then
            null;
            
         else
            case
              TextSchleifenwert
            is
               when SpielstandlisteAnfang .. SpielstandlisteEnde =>
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                     str  => TextSetzen (TextExtern          => To_Wide_Wide_String (Spielstand (TextSchleifenwert - MenueKonstanten.SchleifenanpassungGrafikLogik
                                                                         - MenueKonstanten.SpielstandausgleichLogikGrafik)),
                                                                         SpielstandartExtern => SpielstandartExtern));
                  
               when others =>
                  null;
            end case;
            
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnenGlobaleGrenzen (TextAccessExtern => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                                                                  ViewbreiteExtern => ViewflächeExtern.x);
            
            if
              TextSchleifenwert = MenueKonstanten.EndeAbzugGrafik (MenueDatentypen.Spielstand_Menü_Enum) - MenueKonstanten.SchleifenanpassungGrafikLogik
              and
                LeseGrafiktask.Löschauswahl
                and
                  AuswahlExtern /= TextSchleifenwert - MenueKonstanten.SchleifenanpassungGrafikLogik
            then
               Farbe := Sf.Graphics.Color.sfRed;
               
            elsif
              AuswahlExtern = TextSchleifenwert - MenueKonstanten.SchleifenanpassungGrafikLogik
              and
                LeseGrafiktask.Löschauswahl
                and
                  TextSchleifenwert in SpielstandlisteAnfang .. SpielstandlisteEnde
            then
               Farbe := Sf.Graphics.Color.sfRed;
               
            else
               Farbe := TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => TextSchleifenwert - MenueKonstanten.SchleifenanpassungGrafikLogik,
                                                               AuswahlExtern    => AuswahlExtern);
            end if;
         
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                                                TextbreiteExtern => GrafikKonstanten.Nullwert);
            Skalierung.x := TextskalierungGrafik.Verkleinerung (AktuelleBreiteExtern => Textbreite,
                                                                ErlaubteBreiteExtern => ViewflächeExtern.x);
            Skalierung.y := GrafikRecordKonstanten.Standardskalierung.y;
            
            NeueTextbreite := Textbreite;
            
            TextaccessverwaltungssystemEinfachGrafik.PositionSkalierenFarbeZeichnen (TextaccessExtern => TextaccessVariablen.SpielstandAccess (TextSchleifenwert),
                                                                                     PositionExtern   => Textposition,
                                                                                     SkalierungExtern => Skalierung,
                                                                                     FarbeExtern      => Farbe);
            
            InteraktionAuswahl.PositionenSpielstand (TextSchleifenwert - MenueKonstanten.SchleifenanpassungGrafikLogik)
              := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SpielstandAccess (TextSchleifenwert));
         end if;
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
         
      end loop TextSchleife;
      
      return (NeueTextbreite, Textposition.y);
      
   end Textanzeige;
   
   
   
   function TextSetzen
     (TextExtern : in Wide_Wide_String;
      SpielstandartExtern : in SystemDatentypen.Spielstand_Enum)
      return Wide_Wide_String
   is
      use Ada.Directories;
      use Ada.Calendar.Formatting;
      use Ada.Strings.Wide_Wide_Unbounded;
   begin
      
      if
        TextExtern = TextKonstanten.LeerString
      then
         return TextExtern;
         
      elsif
        False = Exists (Name => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => SpielstandartExtern,
                                                                          SpielstandnameExtern => To_Unbounded_Wide_Wide_String (Source => TextExtern)))
      then
         return TextExtern;
         
      else
         null;
      end if;
      
      return (TextExtern & TextKonstanten.StandardAbstand & UmwandlungssystemHTB3.Decode
              (TextExtern => Local_Image (Date                  => Modification_Time (Name => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => SpielstandartExtern,
                                                                                                                                        SpielstandnameExtern => To_Unbounded_Wide_Wide_String (Source => TextExtern))),
                                          Include_Time_Fraction => False)));
      
   end TextSetzen;

end SpielstandmenueGrafik;
