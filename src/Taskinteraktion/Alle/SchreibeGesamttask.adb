with Gesamttask;

package body SchreibeGesamttask is

   procedure EinstellungenEingelesen
     (JaNeinExtern : in Boolean)
   is begin
      
      Gesamttask.EinstellungenEingelesen := JaNeinExtern;
      
   end EinstellungenEingelesen;

end SchreibeGesamttask;
