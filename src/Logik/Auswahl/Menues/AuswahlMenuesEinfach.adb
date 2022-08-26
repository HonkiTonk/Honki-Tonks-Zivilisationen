pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;

with EingabeSFML;
with RueckgabeMenues;
with NachGrafiktask;
with Mausauswahl;

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
      
         AktuelleAuswahl := Mausauswahl.Menüs (WelchesMenüExtern => WelchesMenüExtern,
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
   
end AuswahlMenuesEinfach;
