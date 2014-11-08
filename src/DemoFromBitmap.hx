import ddls.data.Mesh;
import ddls.data.Object;
import ddls.factories.BitmapObjectFactory;
import ddls.factories.RectMeshFactory;
import ddls.view.SimpleView;

import flash.Lib;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.BitmapData;
import flash.events.KeyboardEvent;



@:bitmap("DemoFromBitmap.png")
class TestImage extends flash.display.BitmapData {}

class DemoFromBitmap extends Sprite
{
    
     var _mesh : Mesh;
     var _view : SimpleView;
     var _object : Object;
    
     var _bmp : Bitmap;
    
    public static function main():Void {
        Lib.current.addChild(new DemoFromBitmap());
    }
    
    public function new()
    {
        super();
        
        // build a rectangular 2 polygons mesh of 600x600
        _mesh = RectMeshFactory.buildRectangle( 600, 600 );
        
        // show the source bmp
		_bmp = new Bitmap(new TestImage(0, 0));
        _bmp.x = 110;
        _bmp.y = 220;
        addChild( _bmp );
        
        // create a viewport
        _view = new SimpleView();
        addChild( _view.surface );
        
        
        // create an object from bitmap
        _object = BitmapObjectFactory.buildFromBmpData(_bmp.bitmapData);
        _object.x = 110;
        _object.y = 220;
        _mesh.insertObject( _object );
        
        
        // display result mesh
        _view.drawMesh( _mesh );
        
		// key presses
        Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
    }
    
     function _onKeyDown(event:KeyboardEvent):Void
    {
        if (event.keyCode == 27) {	// ESC
            #if flash
                flash.system.System.exit(1);
            #elseif sys
                Sys.exit(1);
            #end
        }
    }
}
