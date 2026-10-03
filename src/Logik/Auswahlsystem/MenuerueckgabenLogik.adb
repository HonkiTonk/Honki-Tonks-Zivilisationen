with MeldungssystemHTSEB;

with OftVerwendeterSound;

package body MenuerueckgabenLogik is
   
   function RückgabeMenüs
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive;
      WelchesMenüExtern : in MenueDatentypen.Menü_Ohne_Steuerung_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      OftVerwendeterSound.Klick;
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Spieleinstellungen_Menü_Enum =>
            MitFertigNurFertigZurück := SystemDatentypenHTSEB.Neutral_Enum;
            
         when MenueDatentypen.Kartenpole_Menü_Enum | MenueDatentypen.Kartengröße_Menü_Enum | MenueDatentypen.Kartenebene_Menü_Enum | MenueDatentypen.Kartenart_Menü_Enum | MenueDatentypen.Kartenform_Menü_Enum
            | MenueDatentypen.Kartentemperatur_Menü_Enum | MenueDatentypen.Kartenrohstoffe_Menü_Enum | MenueDatentypen.Schwierigkeitsgrad_Menü_Enum | MenueDatentypen.Spezies_Menü_Enum
            | MenueDatentypen.Debug_Menü_Enum =>
            MitFertigNurFertigZurück := SystemDatentypenHTSEB.True_Enum;
            
         when others =>
            MitFertigNurFertigZurück := SystemDatentypenHTSEB.False_Enum;
      end case;
      
      AuswahlSchleife:
      for AuswahlSchleifenwert in Anfang .. Menüende (WelchesMenüExtern) loop

         if
           AktuelleAuswahlExtern = AuswahlSchleifenwert
         then
            return RueckgabeDatentypen.Rückgabe_Werte_Enum'Val (Grundwert + AuswahlSchleifenwert);

         else
            null;
         end if;

      end loop AuswahlSchleife;
        
      return FertigZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                          AktuelleAuswahlExtern => AktuelleAuswahlExtern,
                                          FertigExtern          => MitFertigNurFertigZurück);
      
   end RückgabeMenüs;
   
   
   
   function SteuerungMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Start_Weiter_Standard_Enum;
         
      else
         return FertigZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                             AktuelleAuswahlExtern => AktuelleAuswahlExtern,
                                             FertigExtern          => SystemDatentypenHTSEB.False_Enum);
      end if;
      
   end SteuerungMenü;
        
   
   
   function FertigZurückHauptmenüEnde
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive;
      FertigExtern : in SystemDatentypenHTSEB.Erweiterter_Boolean_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        FertigExtern
      is
         when SystemDatentypenHTSEB.True_Enum =>
            return RueckgabeDatentypen.Fertig_Enum;
            
         when SystemDatentypenHTSEB.Neutral_Enum =>
            if
              AktuelleAuswahlExtern = EndeExtern - 2
            then
               return RueckgabeDatentypen.Fertig_Enum;
               
            else
               null;
            end if;
            
         when SystemDatentypenHTSEB.False_Enum =>
            if
              AktuelleAuswahlExtern = EndeExtern - 2
            then
               return RueckgabeDatentypen.Zurück_Enum;
               
            else
               null;
            end if;
      end case;
      
      if
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return RueckgabeDatentypen.Hauptmenü_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return RueckgabeDatentypen.Spiel_Beenden_Enum;
                    
      else
         MeldungssystemHTSEB.Logik (MeldungExtern => "MenuerueckgabenLogik.FertigZurückHauptmenüEnde: Falsche Auswahl");
         return RueckgabeDatentypen.Spiel_Beenden_Enum;
      end if;
      
   end FertigZurückHauptmenüEnde;

end MenuerueckgabenLogik;
