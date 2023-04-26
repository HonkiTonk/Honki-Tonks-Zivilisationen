with TastenbelegungDatentypen;
with MenueKonstanten;

with TasteneingabeLogik;
with MenuerueckgabenLogik;
with NachGrafiktask;
with MausauswahlLogik;

package body MenueauswahlLogik is

   function AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Menü_Ohne_Steuerung_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      Ende := MenueKonstanten.EndeAbzugGrafik (WelchesMenüExtern) - 1;
      
      Ausgewählt := Auswahl (WelchesMenüExtern => WelchesMenüExtern,
                              EndeExtern        => Ende);
   
      case
        Ausgewählt
      is
         when RechteMaustaste =>
            return RueckgabeDatentypen.Zurück_Enum;
            
         when others =>
            return MenuerueckgabenLogik.RückgabeMenüs (EndeExtern            => Ende,
                                                         AktuelleAuswahlExtern => Ausgewählt,
                                                         WelchesMenüExtern     => WelchesMenüExtern);
      end case;
      
   end AuswahlMenüsEinfach;

   
   
   function Auswahl
     (WelchesMenüExtern : in MenueDatentypen.Menü_Ohne_Steuerung_Enum;
      EndeExtern : in Positive)
      return Integer
   is begin
      
      AuswahlSchleife:
      loop
      
         AktuelleAuswahl := MausauswahlLogik.Menüs (WelchesMenüExtern => WelchesMenüExtern,
                                                     AnfangExtern      => Anfang,
                                                     EndeExtern        => EndeExtern);
         NachGrafiktask.AktuelleAuswahl.AuswahlEins := AktuelleAuswahl;
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = AuswahlKonstanten.LeerAuswahl
               then
                  null;
                  
               else
                  NachGrafiktask.AktuelleAuswahl.AuswahlEins := AuswahlKonstanten.LeerAuswahl;
                  return AktuelleAuswahl;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               return RechteMaustaste;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end Auswahl;
   
end MenueauswahlLogik;
