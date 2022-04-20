pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;

with SystemDatentypen; use SystemDatentypen;
with TastenbelegungDatentypen;
with GrafikDatentypen;

with GrafikEinstellungenSFML;
with Eingabe;
with RueckgabeMenues;
with InteraktionGrafiktask;
with InteraktionAuswahl;

package body AuswahlMenuesEinfach is

   --------------------------- Das ganze noch einmal unabhängiger schreiben, damit man es zu Not auch auslagern kann und Überschreibungen nicht vorkommen können.
   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      InteraktionGrafiktask.AktuellesMenü := WelchesMenüExtern;
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Menüs_Enum);
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Menü_Ohne_Überschrift_Enum'Range =>
            Ende := SystemKonstanten.EndeMenü (WelchesMenüExtern);
            
         when SystemDatentypen.Menü_Mit_Überschrift_Enum'Range | SystemDatentypen.Menü_Zusatztext_Enum'Range =>
            Ende := SystemKonstanten.EndeMenü (WelchesMenüExtern) - 1;
      end case;
      
      Ausgewählt := Auswahl (WelchesMenüExtern => WelchesMenüExtern,
                             AnfangExtern      => Anfang,
                             EndeExtern        => Ende);
   
      RückgabeWert := RueckgabeMenues.RückgabeMenüs (AnfangExtern          => Anfang,
                                                        EndeExtern            => Ende,
                                                        AktuelleAuswahlExtern => Ausgewählt,
                                                        WelchesMenüExtern     => WelchesMenüExtern);
      
      InteraktionGrafiktask.AktuellesMenü := SystemDatentypen.Leer_Menü_Enum;
      InteraktionGrafiktask.AktuelleDarstellungÄndern (DarstellungExtern => GrafikDatentypen.Grafik_Pause_Enum);
      
      return RückgabeWert;
      
   end AuswahlMenüsEinfach;

      
   
   function Auswahl
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Positive
   is begin
      
      AuswahlSchleife:
      loop
      
         AktuelleAuswahl := MausAuswahl (WelchesMenüExtern => WelchesMenüExtern,
                                         AnfangExtern      => AnfangExtern,
                                         EndeExtern        => EndeExtern);
      
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = SystemKonstanten.LeerAuswahl
               then
                  null;
                  
               else
                  return AktuelleAuswahl;
               end if;
            
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end Auswahl;
   
         
   
   function MausAuswahl
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungenSFML.MausPosition;
      
      PositionSchleife:
      for PositionSchleifenwert in AnfangExtern .. EndeExtern loop
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (InteraktionAuswahl.PositionenEinfach (WelchesMenüExtern, PositionSchleifenwert).top)
             .. Sf.sfInt32 (InteraktionAuswahl.PositionenEinfach (WelchesMenüExtern, PositionSchleifenwert).top + InteraktionAuswahl.PositionenEinfach (WelchesMenüExtern, PositionSchleifenwert).height)
             and
               MausZeigerPosition.x in Sf.sfInt32 (InteraktionAuswahl.PositionenEinfach (WelchesMenüExtern, PositionSchleifenwert).left)
                 .. Sf.sfInt32 (InteraktionAuswahl.PositionenEinfach (WelchesMenüExtern, PositionSchleifenwert).left + InteraktionAuswahl.PositionenEinfach (WelchesMenüExtern, PositionSchleifenwert).width)
         then
            return PositionSchleifenwert;
            
         else
            null;
         end if;
         
      end loop PositionSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end MausAuswahl;
   
end AuswahlMenuesEinfach;
