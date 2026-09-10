with BetriebssystemKonstantenHTSEB;
with TextKonstantenHTSEB;

package body TextaufteilungGrafik is
   
   function Wortsuche
     (AnfangExtern : in Wide_Wide_Character;
      EndeExtern : in Wide_Wide_Character;
      TextExtern : in Wide_Wide_String)
      return Wide_Wide_String
   is begin
      
      
      if
        AnfangExtern /= BetriebssystemKonstantenHTSEB.NUL
        and
          EndeExtern /= BetriebssystemKonstantenHTSEB.NUL
      then
         return Anfangssuche (AnfangExtern => AnfangExtern,
                              EndeExtern   => EndeExtern,
                              TextExtern   => TextExtern);
           
      elsif
        AnfangExtern = BetriebssystemKonstantenHTSEB.NUL
        and
          EndeExtern /= BetriebssystemKonstantenHTSEB.NUL
      then
         return Aufteilung (AnfangspositionExtern => 1,
                            EndeExtern            => EndeExtern,
                            TextExtern            => TextExtern);
         
      else
         return TextExtern;
      end if;
            
   end Wortsuche;
   
   
   
   function Anfangssuche
     (AnfangExtern : in Wide_Wide_Character;
      EndeExtern : in Wide_Wide_Character;
      TextExtern : in Wide_Wide_String)
      return Wide_Wide_String
   is begin
      
      Textposition := 0;
      
      AnfangSchleife:
      for AnfangSchleifenwert in TextExtern'Range loop
            
         if
           TextExtern (AnfangSchleifenwert) = AnfangExtern
           and
             AnfangSchleifenwert = TextExtern'Last
         then
            exit AnfangSchleife;
               
         elsif
           TextExtern (AnfangSchleifenwert) = AnfangExtern
         then
            Textposition := AnfangSchleifenwert + 1;
            exit AnfangSchleife;
               
         else
            null;
         end if;
            
      end loop AnfangSchleife;
         
      case
        Textposition
      is
         when 0 =>
            return TextExtern;
               
         when others =>
            return Aufteilung (AnfangspositionExtern => Textposition,
                               EndeExtern            => EndeExtern,
                               TextExtern            => TextExtern);
      end case;
      
   end Anfangssuche;
   
   
   
   function Aufteilung
     (AnfangspositionExtern : in Positive;
      EndeExtern : in Wide_Wide_Character;
      TextExtern : in Wide_Wide_String)
      return Wide_Wide_String
   is begin
      
      Zwischenspeicher := TextKonstantenHTSEB.LeerUnboundedString;
      
      TextaufteilungSchleife:
      for TextaufteilungSchleifenwert in AnfangspositionExtern .. TextExtern'Last loop
            
         if
           TextExtern (TextaufteilungSchleifenwert) = EndeExtern
         then
            exit TextaufteilungSchleife;
               
         else
            Zwischenspeicher := Zwischenspeicher & TextExtern (TextaufteilungSchleifenwert);
         end if;
            
      end loop TextaufteilungSchleife;
      
      return To_Wide_Wide_String (Source => Zwischenspeicher);
      
   end Aufteilung;

end TextaufteilungGrafik;
