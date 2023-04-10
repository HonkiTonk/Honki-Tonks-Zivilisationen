with LeseAllgemeines;
with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with KIDatentypen;
with KIKonstanten;

with LeseKIVariablen;

with KIEinheitHandlungstestsLogik;
with KIEinheitenAufgabenplanungLogik;
with KIEinheitenbewegungLogik;
with KIEinheitenAufgabenumsetzungLogik;
with KIEinheitAufgabenabbruchLogik;

package body KIEinheitLogik is

   procedure Einheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when KIDatentypen.Platz_Machen_Enum =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern              => KIDatentypen.Leer_Aufgabe_Enum);
            
         when others =>
            null;
      end case;
      
      case
        LeseKIVariablen.Kriegszustand
      is
         when False =>
            if
              KIEinheitHandlungstestsLogik.HandlungBeendet (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
            then
               return;
               
            else
               null;
            end if;
            
         when True =>
            if
              KIEinheitHandlungstestsLogik.BewachtStadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
              or
                KIEinheitHandlungstestsLogik.Unbewegbar (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
            then
               return;
               
            else
               KIEinheitAufgabenabbruchLogik.Friedenshandlung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            end if;
      end case;
                
      Handlungen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
   end Einheit;
   
   
   
   procedure Handlungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      AktivitätSchleife:
      for AktivitätSchleifenwert in KIDatentypen.KINotAus'First .. KIKonstanten.SchwierigkeitsgradAktivität (LeseAllgemeines.Schwierigkeitsgrad) loop
         
         case
           KIEinheitenAufgabenplanungLogik.Aufgabenplanung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
                           
         case
           KIEinheitenbewegungLogik.Bewegung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
         
         case
           KIEinheitenAufgabenumsetzungLogik.Aufgabenumsetzung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
         is
            when True =>
               exit AktivitätSchleife;
               
            when False =>
               null;
         end case;
                  
      end loop AktivitätSchleife;
      
   end Handlungen;

end KIEinheitLogik;
