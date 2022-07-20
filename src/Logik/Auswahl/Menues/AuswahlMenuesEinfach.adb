pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;

with TastenbelegungDatentypen;
with GrafikDatentypen;

with GrafikEinstellungenSFML;
with Eingabe;
with RueckgabeMenues;
with NachGrafiktask;
with InteraktionAuswahl;

package body AuswahlMenuesEinfach is

   --------------------------- Das ganze noch einmal unabhängiger schreiben, damit man es zu Not auch auslagern kann und Überschreibungen nicht vorkommen können.
   --------------------------- Dabei auch mal das Menüanzeigesystem überarbeiten, das ausgeklammerte wird vermutlich nicht mehr benötigt und führt bei Nutzereingaben nur zu ungeeigneter Eingabeanzeige.
   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      NachGrafiktask.AktuellesMenü := WelchesMenüExtern;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Menüs_Enum;
                 
      Ende := SystemKonstanten.EndeMenü (WelchesMenüExtern) - SystemKonstanten.EndeAbzugLogik (WelchesMenüExtern);
      
      Ausgewählt := Auswahl (WelchesMenüExtern => WelchesMenüExtern,
                              AnfangExtern      => Anfang,
                              EndeExtern        => Ende);
   
      RückgabeWert := RueckgabeMenues.RückgabeMenüs (AnfangExtern          => Anfang,
                                                        EndeExtern            => Ende,
                                                        AktuelleAuswahlExtern => Ausgewählt,
                                                        WelchesMenüExtern     => WelchesMenüExtern);
      
      NachGrafiktask.AktuellesMenü := MenueDatentypen.Leer_Menü_Enum;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      
      return RückgabeWert;
      
   end AuswahlMenüsEinfach;

      
   
   function Auswahl
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
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
            ------------------- Hier noch eine Abbruchtaste einbauen?
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
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungenSFML.MausPosition;
      
      PositionSchleife:
      for PositionSchleifenwert in AnfangExtern .. EndeExtern loop
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert).top)
             .. Sf.sfInt32 (InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert).top + InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert).height)
             and
               MausZeigerPosition.x in Sf.sfInt32 (InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert).left)
                 .. Sf.sfInt32 (InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert).left + InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert).width)
         then
            return PositionSchleifenwert;
            
         else
            null;
         end if;
         
      end loop PositionSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end MausAuswahl;
   
end AuswahlMenuesEinfach;
