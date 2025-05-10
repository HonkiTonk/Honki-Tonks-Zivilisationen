with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with StadtKonstanten;

with SchreibeStadtGebaut;

package body LadenStaedteLogik is

   function Städte
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      StadtDatentypen.Städtebereich'Read (Stream (File => DateiLadenExtern),
                                           VorhandeneStädte);
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. VorhandeneStädte loop
         
         case
           Stadtwerte (LadenPrüfenExtern => LadenPrüfenExtern,
                       SpeziesExtern     => SpeziesExtern,
                       DateiLadenExtern  => DateiLadenExtern,
                       StadtExtern       => StadtSchleifenwert)
         is
            when False =>
               return False;
               
            when True =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenStaedteLogik.Städte: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Städte;
   
   
   
   function Stadtwerte
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type;
      StadtExtern : in StadtDatentypen.StädtebereichVorhanden)
      return Boolean
   is begin
      
      StadtRecords.StadtGebautRecord'Read (Stream (File => DateiLadenExtern),
                                           Stadt);
         
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeStadtGebaut.GanzerEintrag (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                               EintragExtern            => Stadt);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenStaedteLogik.Stadtwerte: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Stadtwerte;

end LadenStaedteLogik;
