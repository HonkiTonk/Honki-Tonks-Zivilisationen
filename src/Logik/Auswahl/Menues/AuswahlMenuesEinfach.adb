pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;

with TastenbelegungDatentypen;
with GrafikDatentypen;

with NachLogiktask;
with Eingabe;
with RueckgabeMenues;
with NachGrafiktask;
with InteraktionAuswahl;

package body AuswahlMenuesEinfach is

   -- Das ganze noch einmal unabhängiger schreiben, damit man es zu Not auch auslagern kann und Überschreibungen nicht vorkommen können. äöü
   -- Dabei auch mal das Menüanzeigesystem überarbeiten, das ausgeklammerte wird vermutlich nicht mehr benötigt und führt bei Nutzereingaben nur zu ungeeigneter Eingabeanzeige. äöü
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
   
     -- case
     --   Ausgewählt
    --  is
    --     when SystemKonstanten.LeerAuswahl =>
     --       RückgabeWert := RueckgabeDatentypen.Zurück_Enum;
            
     --    when others =>
            RückgabeWert := RueckgabeMenues.RückgabeMenüs (AnfangExtern          => Anfang,
                                                              EndeExtern            => Ende,
                                                              AktuelleAuswahlExtern => Ausgewählt,
                                                              WelchesMenüExtern     => WelchesMenüExtern);
     -- end case;
      
      NachGrafiktask.AktuellesMenü := MenueDatentypen.Leer_Menü_Enum;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      
      return RückgabeWert;
      
   end AuswahlMenüsEinfach;

      
   
   function Auswahl
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural
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
               
               -- Später noch ordentlich einbauen, hängt aber einiges an Menüs dran. äöü
               --  when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               --     return SystemKonstanten.LeerAuswahl;
            
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
      
      Mausposition := NachLogiktask.Mausposition;
      
      PositionSchleife:
      for PositionSchleifenwert in AnfangExtern .. EndeExtern loop
         
         if
           Mausposition.y in InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert).top
           .. InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert).top + InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert).height
           and
             Mausposition.x in InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert).left
           .. InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert).left + InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert).width
         then
            return PositionSchleifenwert;
            
         else
            null;
         end if;
         
      end loop PositionSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end MausAuswahl;
   
end AuswahlMenuesEinfach;
