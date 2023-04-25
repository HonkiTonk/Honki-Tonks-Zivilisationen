with Sf.Graphics.Text;

with TextaccessVariablen;
with MenueKonstanten;
with MenueDatentypen;
with Meldungstexte;
with TextnummernKonstanten;
with DiplomatieDatentypen;
with Menuetexte;
with GrafikKonstanten;

with LeseDiplomatie;

with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with NachGrafiktask;
with Fehlermeldungssystem;
with TextaccessverwaltungssystemGrafik;

package body ZusatztextDiplomatieGrafik is

   function ZusatztextDiplomatie
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := GrafikKonstanten.Nullwert;
      Textposition.y := ViewflächeExtern.y + TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      
      TextSchleife:
      for TextSchleifenwert in MenueKonstanten.EndeAbzugGrafik (MenueDatentypen.Diplomatie_Menü_Enum) + 1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Diplomatie_Menü_Enum) loop
         
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert),
                                                                                 ViewbreiteExtern => RealeViewbreiteExtern);
               
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MenüsAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert),
                                            str  => TextSetzen (TextnummerExtern => TextSchleifenwert));
      
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.MenüsAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert),
                                                                             TextbreiteExtern => RealeViewbreiteExtern);
      
         TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.MenüsAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert),
                                                             PositionExtern   => Textposition);
      
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.MenüsAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
         
      end loop TextSchleife;
      
      return (Textbreite, Textposition.y);
      
   end ZusatztextDiplomatie;
   
   
   
   function TextSetzen
     (TextnummerExtern : in Positive)
      return Wide_Wide_String
   is begin
      
      if
        TextnummerExtern = MenueKonstanten.EndeMenü (MenueDatentypen.Diplomatie_Menü_Enum)
      then
         case
           LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => NachGrafiktask.AktuelleSpezies,
                                            SpeziesZweiExtern => NachGrafiktask.KontaktierteSpezies)
         is
            when DiplomatieDatentypen.Neutral_Enum =>
               Zustandnummer := TextnummernKonstanten.ZeugFrieden;
               
            when DiplomatieDatentypen.Nichtangriffspakt_Enum =>
               Zustandnummer := TextnummernKonstanten.ZeugNichtangriffspakt;
               
            when DiplomatieDatentypen.Krieg_Enum =>
               Zustandnummer := TextnummernKonstanten.ZeugKrieg;
               
            when DiplomatieDatentypen.Unbekannt_Enum =>
               Fehlermeldungssystem.Grafik (FehlermeldungExtern => "ZusatztextDiplomatieGrafik.TextSetzen: Unbekannter Kontakt");
               return "";
         end case;
         
         Text := Menuetexte.Diplomatiemenü (TextnummerExtern) & " " & Meldungstexte.Zeug (Zustandnummer);
         
      else
         Text := Menuetexte.Diplomatiemenü (TextnummerExtern) & " " & LeseDiplomatie.AktuelleSympathie (SpeziesEinsExtern => NachGrafiktask.AktuelleSpezies,
                                                                                                         SpeziesZweiExtern => NachGrafiktask.KontaktierteSpezies)'Wide_Wide_Image;
      end if;
      
      return To_Wide_Wide_String (Source => Text);
      
   end TextSetzen;

end ZusatztextDiplomatieGrafik;
