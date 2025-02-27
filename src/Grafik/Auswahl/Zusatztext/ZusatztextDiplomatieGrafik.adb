with Sf.Graphics.Text;

with TextaccessVariablen;
with MenueKonstanten;
with MenueDatentypen;
with Spieltexte;
with TextnummernKonstanten;
with DiplomatieDatentypen;
with Menuetexte;
with GrafikKonstanten;

with LeseDiplomatie;
with LeseGrafiktask;

with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with MeldungssystemHTSEB;
with TextaccessverwaltungssystemEinfachGrafik;

package body ZusatztextDiplomatieGrafik is

   function ZusatztextDiplomatie
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := GrafikKonstanten.Nullwert;
      Textposition.y := ViewflächeExtern.y + TextberechnungenHoeheGrafik.Zeilenabstand;
      
      TextSchleife:
      for TextSchleifenwert in MenueKonstanten.EndeAbzugGrafik (MenueDatentypen.Diplomatie_Menü_Enum) + 1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Diplomatie_Menü_Enum) loop
         
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.MenüsAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert),
                                                                                 ViewbreiteExtern => RealeViewbreiteExtern);
               
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.MenüsAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert),
                                            str  => TextSetzen (TextnummerExtern => TextSchleifenwert));
      
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.MenüsAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert),
                                                                             TextbreiteExtern => RealeViewbreiteExtern);
      
         TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.MenüsAccess (MenueDatentypen.Diplomatie_Menü_Enum, TextSchleifenwert),
                                                             PositionExtern   => Textposition);
      
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
         
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
           LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => LeseGrafiktask.AktiveSpezies,
                                            SpeziesZweiExtern => LeseGrafiktask.KontaktiereSpezies)
         is
            when DiplomatieDatentypen.Neutral_Enum =>
               Zustandnummer := TextnummernKonstanten.ZeugFrieden;
               
            when DiplomatieDatentypen.Nichtangriffspakt_Enum =>
               Zustandnummer := TextnummernKonstanten.ZeugNichtangriffspakt;
               
            when DiplomatieDatentypen.Krieg_Enum =>
               Zustandnummer := TextnummernKonstanten.ZeugKrieg;
               
            when DiplomatieDatentypen.Unbekannt_Enum =>
               MeldungssystemHTSEB.Grafik (MeldungExtern => "ZusatztextDiplomatieGrafik.TextSetzen: Unbekannter Kontakt");
               return "";
         end case;
         
         Text := Menuetexte.Diplomatiemenü (TextnummerExtern) & " " & Spieltexte.Zeug (Zustandnummer);
         
      else
         Text := Menuetexte.Diplomatiemenü (TextnummerExtern) & " " & LeseDiplomatie.AktuelleSympathie (SpeziesEinsExtern => LeseGrafiktask.AktiveSpezies,
                                                                                                         SpeziesZweiExtern => LeseGrafiktask.KontaktiereSpezies)'Wide_Wide_Image;
      end if;
      
      return To_Wide_Wide_String (Source => Text);
      
   end TextSetzen;

end ZusatztextDiplomatieGrafik;
