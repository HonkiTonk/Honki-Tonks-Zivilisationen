pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
with Sf.Graphics.RenderWindow;

with TastenbelegungDatentypen;

with NachLogiktask;
with EingabeSFML;
with RueckgabeMenues;
with NachGrafiktask;
with InteraktionAuswahl;
with Vergleiche;
with Views;
with GrafikEinstellungenSFML;

package body AuswahlMenuesEinfach is

   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      Ende := SystemKonstanten.EndeAbzugGrafik (WelchesMenüExtern) - 1;
      
      Ausgewählt := Auswahl (WelchesMenüExtern => WelchesMenüExtern,
                              AnfangExtern      => Anfang,
                              EndeExtern        => Ende);
   
      case
        Ausgewählt
      is
         when RechteMaustaste =>
            RückgabeWert := RueckgabeDatentypen.Zurück_Enum;
            
         when others =>
            RückgabeWert := RueckgabeMenues.RückgabeMenüs (AnfangExtern          => Anfang,
                                                              EndeExtern            => Ende,
                                                              AktuelleAuswahlExtern => Ausgewählt,
                                                              WelchesMenüExtern     => WelchesMenüExtern);
      end case;
      
      return RückgabeWert;
      
   end AuswahlMenüsEinfach;

   
   
   function Auswahl
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Integer
   is begin
      
      AuswahlSchleife:
      loop
      
         AktuelleAuswahl := MausAuswahl (WelchesMenüExtern => WelchesMenüExtern,
                                         AnfangExtern      => AnfangExtern,
                                         EndeExtern        => EndeExtern);
         NachGrafiktask.AktuelleAuswahl.AuswahlEins := AktuelleAuswahl;
         
         case
           EingabeSFML.Tastenwert
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = SystemKonstanten.LeerAuswahl
               then
                  null;
                  
               else
                  NachGrafiktask.AktuelleAuswahl.AuswahlEins := SystemKonstanten.LeerAuswahl;
                  return AktuelleAuswahl;
               end if;
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               return RechteMaustaste;
               
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
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.MenüviewAccess);
      
      PositionSchleife:
      for PositionSchleifenwert in AnfangExtern .. EndeExtern loop
                  
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenMenüeinträge (WelchesMenüExtern, PositionSchleifenwert))
         is
            when True =>
               return PositionSchleifenwert;
            
            when False =>
               null;
         end case;
         
      end loop PositionSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end MausAuswahl;
   
end AuswahlMenuesEinfach;
